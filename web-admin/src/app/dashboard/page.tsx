import AdminLayout from "@/components/layout/adminLayout";
import StatCard from "@/components/ui/statCard";

export default function DashboardPage() {

  // dummy data dulu
  const stats = {
    total: 2,
    proses: 1,
    selesai: 0,
    ditolak: 0,
  };

  const laporanTerbaru = [
    {
      id: 1,
      judul: "Jalan rusak",
      status: "MENUNGGU",
    },
    {
      id: 2,
      judul: "Lampu mati",
      status: "DIPROSES",
    },
  ];

  return (
    <AdminLayout>

      {/* Statistik */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6 text-gray-500">
        <StatCard title="Total Laporan" value={stats.total} color="text-blue-500" />
        <StatCard title="Diproses" value={stats.proses} color="text-yellow-500" />
        <StatCard title="Selesai" value={stats.selesai} color="text-green-500" />
        <StatCard title="Ditolak" value={stats.ditolak} color="text-red-500" />
      </div>

      {/* Tabel */}
      <div className="bg-white rounded-xl shadow p-4">
        <h2 className="font-semibold mb-4 text-gray-500">Laporan Terbaru</h2>

        <table className="w-full text-sm text-gray-500">
          <thead>
            <tr className="text-left border-b">
              <th className="p-2">Judul</th>
              <th className="p-2">Status</th>
            </tr>
          </thead>

          <tbody>
            {laporanTerbaru.map((item) => (
              <tr key={item.id} className="border-b">
                <td className="p-2">{item.judul}</td>
                <td className="p-2">
                  <span className="px-2 py-1 bg-blue-100 text-blue-600 rounded text-xs">
                    {item.status}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>

        </table>
      </div>

    </AdminLayout>
  );
}