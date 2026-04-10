import Link from "next/link";

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex min-h-screen bg-gray-100">

      {/* Sidebar */}
      <aside className="w-64 bg-gray-900 text-white p-5">
        <h1 className="text-xl font-bold mb-8">LaporDesa</h1>

        <ul className="space-y-4 text-sm">
          <Link href="/dashboard">
            <li className="hover:bg-gray-700 p-2 rounded cursor-pointer">Dashboard</li>
          </Link>
          <Link href="/laporan">
            <li className="hover:bg-gray-700 p-2 rounded cursor-pointer">Laporan</li>
          </Link>
          <Link href="/users">
            <li className="hover:bg-gray-700 p-2 rounded cursor-pointer">Users</li>
          </Link>
        </ul>
      </aside>

      {/* Content */}
      <div className="flex-1 flex flex-col">

        {/* Header */}
        <header className="bg-gray-800 shadow p-4 flex justify-between">
          <h2 className="font-semibold text-2xl">Dashboard</h2>
          <button className="text-sm bg-red-500 text-white px-3 py-1 rounded">
            Logout
          </button>
        </header>

        {/* Main */}
        <main className="p-6">{children}</main>

      </div>
    </div>
  );
}