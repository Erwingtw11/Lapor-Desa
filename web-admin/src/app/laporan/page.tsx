import AdminLayout from "@/components/layout/adminLayout";
import { getLaporan } from "@/lib/api";
import Link from "next/link";

export default async function LaporanPage() {
  const data = await getLaporan();

  return (
    <AdminLayout>
      
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800">
          Data Laporan
        </h1>
        <p className="text-sm text-gray-500">
          Daftar laporan masyarakat
        </p>
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl shadow overflow-hidden">
        <table className="w-full text-sm">
          
          {/* Head */}
          <thead className="bg-gray-100 text-gray-600">
            <tr>
              <th className="p-3 text-left">Judul</th>
              <th className="p-3 text-left">Deskripsi</th>
              <th className="p-3 text-left">Status</th>
              <th className="p-3 text-left">Aksi</th>
            </tr>
          </thead>

          {/* Body */}
          <tbody>
            {data.map((laporan) => (
              <tr
                key={laporan.id}
                className="border-t hover:bg-gray-50 transition"
              >
                <td className="p-3 font-medium text-gray-800">
                  {laporan.judul}
                </td>

                <td className="p-3 text-gray-600">
                  {laporan.deskripsi}
                </td>

                {/* Status dengan warna */}
                <td className="p-3">
                  <span
                    className={`px-2 py-1 rounded text-xs font-semibold ${
                      laporan.status === "SELESAI"
                        ? "bg-green-100 text-green-600"
                        : laporan.status === "DIPROSES"
                        ? "bg-blue-100 text-blue-600"
                        : laporan.status === "DITOLAK"
                        ? "bg-red-100 text-red-600"
                        : "bg-yellow-100 text-yellow-600"
                    }`}
                  >
                    {laporan.status}
                  </span>
                </td>

                {/* Button */}
                <td className="p-3">
                  <button className="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1.5 rounded-lg text-xs transition">
                    <Link href={`/laporan/${laporan.id}`}>Detail</Link>
                  </button>
                </td>
              </tr>
            ))}
          </tbody>

        </table>
      </div>

    </AdminLayout>
  );
}