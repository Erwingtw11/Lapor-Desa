import { PrismaClient, ReportStatus, Role } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  const adminPassword = await bcrypt.hash('Admin123!', 10);
  const userPassword = await bcrypt.hash('User123!', 10);

  const admin = await prisma.user.upsert({
    where: { email: 'admin@lapordesa.id' },
    update: {},
    create: {
      name: 'Admin Desa',
      email: 'admin@lapordesa.id',
      password: adminPassword,
      role: Role.ADMIN,
    },
  });

  const budi = await prisma.user.upsert({
    where: { email: 'budi@lapordesa.id' },
    update: {},
    create: {
      name: 'Budi Santoso',
      email: 'budi@lapordesa.id',
      password: userPassword,
      role: Role.USER,
    },
  });

  const sari = await prisma.user.upsert({
    where: { email: 'sari@lapordesa.id' },
    update: {},
    create: {
      name: 'Sari Lestari',
      email: 'sari@lapordesa.id',
      password: userPassword,
      role: Role.USER,
    },
  });

  const sampleReports = [
    {
      userId: budi.id,
      title: 'Jalan Desa Berlumpur',
      description:
        'Akses jalan menuju dusun 2 rusak berat setelah hujan deras.',
      image: '/uploads/sample-road.png',
      location: 'Dusun 2, RT 03',
      status: ReportStatus.PENDING,
    },
    {
      userId: sari.id,
      title: 'Lampu Jalan Mati',
      description:
        'Lampu jalan di dekat balai desa tidak menyala selama 4 hari.',
      image: '/uploads/sample-lamp.png',
      location: 'Depan Balai Desa',
      status: ReportStatus.PROCESS,
    },
  ];

  for (const report of sampleReports) {
    const existingReport = await prisma.report.findFirst({
      where: {
        userId: report.userId,
        title: report.title,
      },
    });

    if (!existingReport) {
      await prisma.report.create({ data: report });
    }
  }

  console.log('Seed selesai:', {
    admin: admin.email,
    users: [budi.email, sari.email],
  });
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
