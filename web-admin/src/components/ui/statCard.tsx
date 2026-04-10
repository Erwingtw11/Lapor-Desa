interface Props {
  title: string;
  value: number;
  color: string;
}

export default function StatCard({ title, value, color }: Props) {
  return (
    <div className="bg-white p-4 rounded-xl shadow">
      <p className="text-sm text-gray-500">{title}</p>
      <h2 className={`text-2xl font-bold ${color}`}>{value}</h2>
    </div>
  );
}