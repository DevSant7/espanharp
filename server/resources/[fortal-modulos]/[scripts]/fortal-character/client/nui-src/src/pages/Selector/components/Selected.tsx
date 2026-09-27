import { Post } from "@/hooks/post";
import { useCharacters } from "../stores/useCharacters";
import { useSelection } from "../stores/useSelection";

export default function Selected() {
  const { current: selected } = useSelection();
  const { current: characters } = useCharacters();
  const character = characters[selected];

  return (
    (character && character.type === "character") && (
      <section className="absolute right-20 top-1/2 flex w-[21.25rem] -translate-y-1/2 flex-col gap-5">
        <header className="flex w-full flex-col items-end gap-2 overflow-visible">
          <p className="overflow-visible text-xl font-medium leading-none text-white/65">
            Informações do
          </p>
          <h1 className="overflow-visible text-[1.875rem] font-bold uppercase leading-none text-white">
            personagem
          </h1>
        </header>
        <div className="bg-section flex w-full flex-col gap-4 rounded-md border border-white/10 p-5">
          <div className="flex flex-col gap-2">
            <Data title="nome" value={character.name} />
            <Data
              title="id"
              value={
                "#" +
                character.id.toLocaleString("pt-br", {
                  maximumFractionDigits: 0,
                })
              }
            />
            <Data title="idade" value={character.age + " ANOS"} />
            <Data title="telefone" value={character.phone} />
            <Data title="gênero" value={(character.gender === "m" ? "MASCULINO" : "FEMININO").toUpperCase()} />
          </div>
          <Data
            title="banco"
            value={character.bank.toLocaleString("pt-br", {
              maximumFractionDigits: 0,
              style: "currency",
              currency: "BRL",
            })}
          />
        </div>
        <button
          onClick={() => {
            Post.create("Selector:SelectCharacter", character)
          }}
          className="flex items-center justify-center gap-3 bg-gradient-primary h-[4.0625rem] w-full rounded-md border border-primary text-lg font-semibold text-white hover:opacity-80 active:scale-95 transition-all duration-200"
        >
          JOGAR
        </button>
      </section>
    )
  );
}

const Data = ({ title, value }: Record<string, string>) => {
  return (
    <div className="flex h-[3.25rem] w-full items-center justify-between gap-6 rounded border border-white/5 bg-white/3 pl-[1.13rem] pr-4">
      <p className="flex-none text-sm font-medium uppercase tracking-wider text-white">
        {title}
      </p>
      <div className="flex items-center gap-4">
        <p className="truncate text-base font-bold text-white">{value}</p>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className="w-5 flex-none"
          viewBox="0 0 20 17"
          fill="none"
        >
          <path
            opacity="0.1"
            d="M17.9199 0.799805C18.2588 0.799805 18.5841 0.933699 18.8242 1.17188C19.0644 1.41016 19.2002 1.73362 19.2002 2.07129V14.9287C19.2002 15.2664 19.0644 15.5898 18.8242 15.8281C18.5841 16.0663 18.2588 16.2002 17.9199 16.2002H2.08008C1.74118 16.2002 1.41593 16.0663 1.17578 15.8281C0.935594 15.5898 0.799842 15.2664 0.799805 14.9287V2.07129C0.799842 1.73362 0.935594 1.41016 1.17578 1.17188C1.41594 0.933698 1.74118 0.799805 2.08008 0.799805H17.9199ZM2.08008 1.91406C2.03713 1.91406 1.99571 1.93129 1.96582 1.96094C1.93619 1.99047 1.91996 2.0303 1.91992 2.07129V14.9287C1.91996 14.9697 1.93619 15.0095 1.96582 15.0391C1.99571 15.0687 2.03713 15.0859 2.08008 15.0859H17.9199C17.9629 15.0859 18.0043 15.0687 18.0342 15.0391C18.0638 15.0095 18.08 14.9697 18.0801 14.9287V2.07129C18.08 2.0303 18.0638 1.99047 18.0342 1.96094C18.0043 1.93129 17.9629 1.91406 17.9199 1.91406H2.08008ZM7.12012 5.08398C7.70436 5.08401 8.27304 5.27112 8.74219 5.61719C9.21127 5.96322 9.55604 6.44995 9.72461 7.00586C9.89313 7.56197 9.87697 8.15811 9.67773 8.7041C9.51693 9.14459 9.24228 9.53204 8.88672 9.83398C9.23938 10.0289 9.55619 10.2833 9.82129 10.5879C10.158 10.9748 10.4029 11.4315 10.5391 11.9248H10.54C10.5616 11.9966 10.568 12.072 10.5596 12.1465C10.5512 12.221 10.5282 12.2932 10.4912 12.3584C10.4541 12.4237 10.4035 12.4808 10.3438 12.5264C10.2841 12.5718 10.2162 12.6054 10.1436 12.624C10.0708 12.6427 9.99421 12.6468 9.91992 12.6357C9.84589 12.6246 9.77488 12.5985 9.71094 12.5596C9.64681 12.5204 9.59059 12.4684 9.54688 12.4072C9.50473 12.3482 9.47453 12.2815 9.45801 12.2109L9.40234 12.0303C9.08107 11.1438 8.13838 10.4854 7.12012 10.4854C6.03512 10.4854 5.03884 11.2331 4.78125 12.21L4.78223 12.2109C4.75104 12.3308 4.68013 12.4373 4.58203 12.5127C4.50856 12.5691 4.42249 12.6061 4.33203 12.6211L4.24023 12.6289C4.19256 12.629 4.14473 12.6225 4.09863 12.6104V12.6094C3.95615 12.5722 3.8331 12.4812 3.75781 12.3545C3.68234 12.2272 3.66104 12.0749 3.69824 11.9316L3.69922 11.9287C3.83559 11.4341 4.08129 10.9758 4.41895 10.5879C4.68384 10.2836 5.00033 10.0291 5.35254 9.83398C4.99721 9.5321 4.72324 9.14438 4.5625 8.7041C4.36326 8.15811 4.3471 7.56197 4.51562 7.00586C4.6842 6.44998 5.02898 5.96321 5.49805 5.61719C5.9672 5.27117 6.5359 5.08398 7.12012 5.08398ZM15.7598 9.37109C15.9078 9.37109 16.0501 9.42988 16.1553 9.53418C16.2605 9.63854 16.3203 9.78043 16.3203 9.92871C16.3203 10.0769 16.2604 10.2189 16.1553 10.3232C16.0501 10.4275 15.9077 10.4854 15.7598 10.4854H12.1602C12.0122 10.4854 11.8698 10.4275 11.7646 10.3232C11.6595 10.2189 11.5996 10.0769 11.5996 9.92871C11.5996 9.78045 11.6595 9.63854 11.7646 9.53418C11.8698 9.42987 12.0121 9.37109 12.1602 9.37109H15.7598ZM7.43262 6.23047C7.12193 6.16916 6.79939 6.20107 6.50684 6.32129C6.21448 6.44153 5.9646 6.64465 5.78906 6.90527C5.61347 7.166 5.51953 7.47288 5.51953 7.78613C5.51964 8.20602 5.6885 8.60885 5.98828 8.90625C6.28822 9.20379 6.69527 9.37109 7.12012 9.37109C7.43688 9.37107 7.74664 9.27794 8.00977 9.10352C8.27277 8.92909 8.47777 8.68107 8.59863 8.3916C8.71938 8.10216 8.75103 7.78369 8.68945 7.47656C8.62783 7.16931 8.47557 6.88689 8.25195 6.66504C8.02833 6.44319 7.74323 6.2918 7.43262 6.23047ZM15.7598 6.51465C15.9077 6.51465 16.0501 6.57254 16.1553 6.67676C16.2604 6.78108 16.3203 6.92306 16.3203 7.07129C16.3203 7.21957 16.2605 7.36146 16.1553 7.46582C16.0501 7.57012 15.9078 7.62891 15.7598 7.62891H12.1602C12.0121 7.62891 11.8698 7.57013 11.7646 7.46582C11.6595 7.36146 11.5996 7.21955 11.5996 7.07129C11.5996 6.92306 11.6595 6.78108 11.7646 6.67676C11.8698 6.57252 12.0122 6.51465 12.1602 6.51465H15.7598Z"
            fill="white"
            stroke="white"
            strokeWidth="0.4"
          />
        </svg>
      </div>
    </div>
  );
};
