import { cn } from "@/utils/misc";
import { Post } from "@/hooks/post";
import { useCharacters, type Character } from "../stores/useCharacters";
import { useSelection } from "../stores/useSelection";

export default function Characters() {
  const { current: chars } = useCharacters();
  return (
    <section className="absolute left-14 top-1/2 flex -translate-y-1/2 flex-col gap-[2.69rem] overflow-visible">
      <header className="flex flex-col items-start gap-2 overflow-visible">
        <p className="overflow-visible text-xl font-medium leading-none text-white/65">
          Escolha seu
        </p>
        <h1 className="overflow-visible text-[1.875rem] font-bold uppercase leading-none text-white">
          personagem
        </h1>
      </header>
      <div className="flex flex-col gap-2.5">
        {chars.map((data, index) => {
          if (data.type === "character") {
            return <CharacterSlot data={data} index={index} key={index} />;
          } else if (data.type === "slot") {
            return <Slot index={index} key={index} />;
          }
        })}
      </div>
    </section>
  );
}

const CharacterSlot = ({ data, index }: { data: Character; index: number }) => {
  const { current: selected, set: setSelected } = useSelection();
  const active = selected === index;
  return (
    data.type === "character" && (
      <button
        className={cn(
          "bg-section flex h-[4.3125rem] w-[24.125rem] items-center justify-between rounded-md border border-white/10 px-4",
          !active && "opacity-55",
        )}
        onClick={() => {
          const key = (active ? -1 : index)

          Post.create("Selector:PreviewCharacter", { index: key + 1 });
          setSelected(key)
        }}
      >
        <div className="flex flex-col items-start gap-[0.19rem] overflow-visible">
          <p className="overflow-visible text-base font-bold leading-none text-white">
            {data.name}
          </p>
          <p className="overflow-visible text-base font-medium leading-none text-white/70">
            {data.bank.toLocaleString("pt-br", {
              style: "currency",
              currency: "BRL",
              maximumFractionDigits: 0,
            })}
          </p>
        </div>
        <div
          className={cn(
            "flex h-[2.3125rem] items-center rounded-lg border px-2.5 text-lg font-bold leading-none",
            active
              ? "bg-gradient-primary border-primary text-white"
              : "bg-section border-white/10 text-white/85",
          )}
        >
          #
          {data.id.toLocaleString("pt-br", {
            maximumFractionDigits: 0,
          })}
        </div>
      </button>
    )
  );
};
const Slot = ({ index }: { index: number }) => {
  const { current: selected, set: setSelected } = useSelection();
  const active = selected === index;
  return (
    <button
      className={cn(
        "bg-section flex h-[4.3125rem] w-[24.125rem] items-center justify-between rounded-md border border-white/10 px-4",
        !active && "opacity-55",
      )}
      onClick={() => {
        const key = (active ? -1 : index)

        Post.create("Selector:PreviewCharacter", { index: key + 1 });
        setSelected(active ? -1 : index)
      }}
    >
      <div className="flex flex-col items-start gap-[0.19rem] overflow-visible">
        <p className="overflow-visible text-base font-bold leading-none text-white">
          Novo Personagem
        </p>
        <p className="overflow-visible text-base font-medium leading-none text-white/70">
          Crie um novo personagem agora
        </p>
      </div>
      <div
        className={cn(
          "flex h-[2.3125rem] items-center gap-2 rounded-lg border px-2.5 font-bold",
          active
            ? "bg-gradient-primary border-primary text-white"
            : "bg-section border-white/10 text-white/85",
        )}
      >
        <svg 
          xmlns="http://www.w3.org/2000/svg"
          className="h-[1.0625rem]"
          viewBox="0 0 24 24" 
          fill="none" 
        >
          <path 
            d="M4 12H20M12 4V20" 
            className={cn(active ? "stroke-white" : "stroke-white/85")}
            strokeWidth="3" 
            strokeLinecap="round" 
            strokeLinejoin="round"
          />
        </svg>
      </div>
    </button>
  );
};
