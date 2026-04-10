export async function getLaporan() {
  return [
    {
      id: "1",
      judul: "Jalan rusak",
      deskripsi: "Lubang besar di tengah jalan",
      status: "MENUNGGU",
      lokasi: "Desa Mulya Agung",
    },
    {
      id: "2",
      judul: "Lampu Mati",
      deskripsi: "Lampu perumahan di komplek mati",
      status: "DIPROSES",
      lokasi: "Desa Agung Batin",
    },
    {
      id: "3",
      judul: "Sampah menumpuk",
      deskripsi: "Sampah menumpuk di pinggir jalan",
      status: "SELESAI",
      lokasi: "Desa Mulya Agung",
    },
    {
      id: "4",
      judul: "Janda melarikan diri",
      deskripsi: "Janda melarikan diri dari rumahnya",
      status: "DITOLAK",
      lokasi: "Desa Simpang Mesuji",
    },
    {
      id: "5",
      judul: "Pohon tumbang",
      deskripsi: "Pohon tumbang menghalangi jalan",
      status: "DIPROSES",
      lokasi: "Desa Simpang Pematang",
    },
  ];
}