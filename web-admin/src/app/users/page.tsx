"use client";

import AdminLayout from "@/components/layout/adminLayout";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

interface User {
  id: number;
  nama: string;
  email: string;
  role: string;
}

export default function UsersPage() {
  const router = useRouter();

  // 🔐 dummy auth dulu (nanti ganti dari login/session)
  const currentUser = {
    role: "ADMIN", // ganti "USER" untuk test redirect
  };

  // state user
  const [users, setUsers] = useState<User[]>([]);

  // 🔥 proteksi halaman
  useEffect(() => {
    if (currentUser.role !== "ADMIN") {
      router.push("/dashboard");
    }
  }, []);

  // 🔥 ambil data user (dummy dulu)
  useEffect(() => {
    const fetchUsers = async () => {
      // nanti ganti ke API NestJS
      const data: User[] = [
        {
          id: 1,
          nama: "Admin Desa",
          email: "admin@gmail.com",
          role: "ADMIN",
        },
        {
          id: 2,
          nama: "Budi",
          email: "budi@gmail.com",
          role: "USER",
        },
      ];

      setUsers(data);
    };

    fetchUsers();
  }, []);

  // 🔥 fungsi hapus user
  const handleDelete = async (id: number) => {
    const confirmDelete = confirm("Yakin mau hapus user ini?");
    if (!confirmDelete) return;

    try {
      // nanti ganti ke API backend
      setUsers((prev) => prev.filter((user) => user.id !== id));

      alert("User berhasil dihapus");
    } catch (error) {
      alert("Gagal hapus user");
    }
  };

  return (
    <AdminLayout>
      {/* Header */}
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">
            Data Users
          </h1>
          <p className="text-sm text-gray-500">
            Manajemen pengguna sistem
          </p>
        </div>
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl shadow overflow-hidden">
        <table className="w-full text-sm">
          
          <thead className="bg-gray-100 text-gray-600">
            <tr>
              <th className="p-3 text-left">Nama</th>
              <th className="p-3 text-left">Email</th>
              <th className="p-3 text-left">Role</th>
              <th className="p-3 text-left">Aksi</th>
            </tr>
          </thead>

          <tbody>
            {users.map((user) => (
              <tr
                key={user.id}
                className="border-t hover:bg-gray-50 transition"
              >
                <td className="p-3 font-medium text-gray-800">
                  {user.nama}
                </td>

                <td className="p-3 text-gray-600">
                  {user.email}
                </td>

                {/* Role */}
                <td className="p-3">
                  <span
                    className={`px-2 py-1 rounded text-xs font-semibold ${
                      user.role === "ADMIN"
                        ? "bg-purple-100 text-purple-600"
                        : "bg-blue-100 text-blue-600"
                    }`}
                  >
                    {user.role}
                  </span>
                </td>

                {/* Aksi */}
                <td className="p-3">
                  <button
                    onClick={() => handleDelete(user.id)}
                    className="bg-red-500 hover:bg-red-600 text-white px-3 py-1.5 rounded-lg text-xs transition"
                  >
                    Hapus
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