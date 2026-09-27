export default function Header({ page }: { page: string }) {
  return (
    <header className="flex w-[25.9375rem] flex-col items-center">
      <p className="text-xl font-medium text-white/65">
        {page === "1" ? "Primárias" : "Secundárias"}
      </p>
      <h1 className="text-[2.1875rem] font-bold uppercase leading-normal text-light">
        roupas
      </h1>
    </header>
  );
}
