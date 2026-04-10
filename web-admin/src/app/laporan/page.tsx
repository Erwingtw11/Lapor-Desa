import AdminLayout from "@/components/layout/adminLayout";
import { getLaporan } from "@/lib/api";

export default async function LaporanPage() {
  const data = await getLaporan();

  return (
    <AdminLayout>
      <h1 className="text-2xl font-bold mb-4">Data Laporan</h1>

      <table className="w-full bg-white rounded-lg shadow">
        <thead>
          <tr className="bg-gray-200">
            <th className="p-2">Judul</th>
            <th className="p-2">Deskripsi</th>
            <th className="p-2">Status</th>
            <th className="p-2">Aksi</th>
          </tr>
        </thead>
        <tbody>
          {data.map((laporan) => (
            <tr key={laporan.id}>
              <td className="p-2">{laporan.judul}</td>
              <td className="p-2">{laporan.deskripsi}</td>
              <td className="p-2">{laporan.status}</td>
              <td className="p-2">
                <button className="bg-blue-500 text-white px-3 py-1 rounded">
                  Detail
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </AdminLayout>
  );
}