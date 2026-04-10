export default function AdminLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex">
      <aside className="w-64 h-screen bg-gray-800 text-white p-4">
        <h1 className="text-xl font-bold mb-6">LaporDesa</h1>
        <ul className="space-y-3">
          <li>Dashboard</li>
          <li>Laporan</li>
          <li>Users</li>
        </ul>
      </aside>

      <main className="flex-1 p-6 bg-gray-100">
        {children}
      </main>
    </div>
  );
}