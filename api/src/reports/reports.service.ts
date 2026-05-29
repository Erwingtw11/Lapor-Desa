import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { Prisma, ReportStatus, Role } from '@prisma/client';
import { existsSync, unlinkSync } from 'fs';
import { join } from 'path';
import { PrismaService } from '../prisma/prisma.service';
import { RequestUser } from '../common/interfaces/request-user.interface';
import { CreateReportDto } from './dto/create-report.dto';
import { UpdateReportDto } from './dto/update-report.dto';

@Injectable()
export class ReportsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    currentUser: RequestUser,
    dto: CreateReportDto,
    file?: Express.Multer.File,
  ) {
    if (!file) {
      throw new BadRequestException('Foto laporan wajib diupload.');
    }

    return this.prisma.report.create({
      data: {
        userId: currentUser.id,
        title: dto.title,
        description: dto.description,
        location: dto.location,
        image: `/uploads/${file.filename}`,
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });
  }

  async findAll(currentUser: RequestUser) {
    const where: Prisma.ReportWhereInput =
      currentUser.role === Role.ADMIN ? {} : { userId: currentUser.id };

    return this.prisma.report.findMany({
      where,
      orderBy: {
        createdAt: 'desc',
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });
  }

  async findOne(id: number, currentUser: RequestUser) {
    const report = await this.prisma.report.findUnique({
      where: { id },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });

    if (!report) {
      throw new NotFoundException('Laporan tidak ditemukan.');
    }

    this.ensurePermission(report.userId, currentUser);
    return report;
  }

  async update(id: number, dto: UpdateReportDto, currentUser: RequestUser) {
    const report = await this.prisma.report.findUnique({
      where: { id },
    });

    if (!report) {
      throw new NotFoundException('Laporan tidak ditemukan.');
    }

    this.ensurePermission(report.userId, currentUser);

    if (currentUser.role === Role.USER && dto.status) {
      throw new ForbiddenException('User tidak boleh mengubah status laporan.');
    }

    return this.prisma.report.update({
      where: { id },
      data: dto,
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });
  }

  async remove(id: number, currentUser: RequestUser) {
    const report = await this.prisma.report.findUnique({
      where: { id },
    });

    if (!report) {
      throw new NotFoundException('Laporan tidak ditemukan.');
    }

    this.ensurePermission(report.userId, currentUser);

    const deletedReport = await this.prisma.report.delete({
      where: { id },
    });

    if (deletedReport.image?.startsWith('/uploads/')) {
      const imagePath = join(
        process.cwd(),
        deletedReport.image.replace('/uploads/', 'uploads/'),
      );

      if (existsSync(imagePath)) {
        unlinkSync(imagePath);
      }
    }

    return {
      message: 'Laporan berhasil dihapus.',
    };
  }

  private ensurePermission(reportOwnerId: number, currentUser: RequestUser) {
    const isAdmin = currentUser.role === Role.ADMIN;
    const isOwner = currentUser.id === reportOwnerId;

    if (!isAdmin && !isOwner) {
      throw new ForbiddenException('Anda tidak memiliki akses ke laporan ini.');
    }
  }

  countByStatus(reports: { status: ReportStatus }[]) {
    return {
      total: reports.length,
      pending: reports.filter(
        (report) => report.status === ReportStatus.PENDING,
      ).length,
      process: reports.filter(
        (report) => report.status === ReportStatus.PROCESS,
      ).length,
      done: reports.filter((report) => report.status === ReportStatus.DONE)
        .length,
    };
  }
}
