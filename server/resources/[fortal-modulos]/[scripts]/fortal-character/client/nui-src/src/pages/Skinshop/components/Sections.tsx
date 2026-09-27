import { cn } from "@/utils/misc";

export default function Sections({
  page,
  setPage,
}: {
  page: string;
  setPage: (page: string) => void;
}) {
  return (
    <div className="bg-gradient-primary flex flex-col gap-1.5 rounded-lg p-1.5">
      <button
        onClick={() => setPage("1")}
        className={cn(
          "mx-auto grid size-[3.1875rem] place-items-center rounded-md border border-white/10 text-[1.375rem] font-medium leading-none",
          page === "1" ? "bg-white text-primary" : "bg-white/10 text-white/75",
        )}
      >
        1°
      </button>
      <button
        onClick={() => setPage("2")}
        className={cn(
          "mx-auto grid size-[3.1875rem] place-items-center rounded-md border border-white/10 text-[1.375rem] font-medium leading-none",
          page === "2" ? "bg-white text-primary" : "bg-white/10 text-white/75",
        )}
      >
        2°
      </button>
    </div>
  );
}
