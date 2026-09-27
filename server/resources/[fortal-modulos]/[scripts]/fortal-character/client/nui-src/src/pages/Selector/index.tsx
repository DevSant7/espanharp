import { Background } from "@/components/Background";
import Balance from "./components/Balance";
import Characters from "./components/Characters";
import { Post } from "@/hooks/post";
import Selected from "./components/Selected";
import { cn } from "@/utils/misc";
import { useCharacters, type Character } from "./stores/useCharacters";
import { useEffect } from "react";
import { useSelection } from "./stores/useSelection";
import { usePopup } from "@/stores/usePopup";

export default function Selector() {
  const { set: setPopup } = usePopup();
  const { current: selected, set: setSelected } = useSelection();
  const characters = useCharacters();
  useEffect(() => {
    Post.create<Character[]>(
      "Selector:GetData",
      {},
      [
        {
          type: "character",
          name: "Enrique Marquez",
          id: 3613,
          gender: "Masculino",
          age: 18,
          bank: 3000000,
          phone: "563-988",
          gems: 0,
        },
        {
          type: "slot",
        },
        {
          type: "slot",
        },
      ],
    ).then(characters.set);

    setSelected(-1)
  }, []);

  const deleteCharacter = (data: typeof characters.current[typeof selected]) => {
    const currentSelected = selected
    
    setSelected(-1)
    Post.create<boolean>("Selector:DeleteCharacter", data).then((response) => {
      if (response) {
        const newCharacters = characters.current
        newCharacters[currentSelected] = { type: "slot" }

        characters.set(newCharacters)
      }
    })
  }

  return (
    <Background>
      <main className="h-screen w-screen bg-[radial-gradient(70.28%_70.28%_at_50%_50%,_rgba(255,_255,_255,_0.00)_48.55%,_rgba(255,_255,_255,_0.01)_100%)]">
        <div className="size-full bg-gradient-to-r from-[#070916a3] to-transparent to-[50%]">
          <Balance />
          {characters.current[selected] ? (
            <button
              onClick={() => {
                if (characters.current[selected].type === "character") {
                  setPopup({
                    title: "DELETAR PERSONAGEM",
                    description: `Tem certeza que deseja deletar o personagem ${characters.current[selected].name}?`,
                    callback: () => deleteCharacter(characters.current[selected])
                  })
                } else {
                  Post.create("Selector:CreateCharacter")
                }
              }}
              disabled={selected < 0}
              className={cn(
                "group absolute bottom-14 left-14 flex h-[3.4375rem] items-center gap-3.5 rounded-lg border border-white/5 bg-white/10 pl-[1.31rem] pr-5",
                selected >= 0 && "bg-white/10 hover:bg-primary active:scale-95 transition-all duration-200",
              )}
            >
              {characters.current[selected].type === "character" ? (
                <svg 
                  xmlns="http://www.w3.org/2000/svg" 
                  className={cn(
                    "w-6 opacity-55",
                    selected >= 0 && "group-hover:opacity-100 transition-all duration-200",
                  )}
                  viewBox="-3 0 32 32" 
                >
                    <g id="Page-1" stroke="none" strokeWidth="1" fill="none" fillRule="evenodd">
                        <g id="Icon-Set" transform="translate(-261.000000, -205.000000)" fill="#ffffffff">
                            <path 
                              d="M268,220 C268,219.448 268.448,219 269,219 C269.552,219 270,219.448 270,220 L270,232 C270,232.553 269.552,233 269,233 C268.448,233 268,232.553 268,232 L268,220 L268,220 Z M273,220 C273,219.448 273.448,219 274,219 C274.552,219 275,219.448 275,220 L275,232 C275,232.553 274.552,233 274,233 C273.448,233 273,232.553 273,232 L273,220 L273,220 Z M278,220 C278,219.448 278.448,219 279,219 C279.552,219 280,219.448 280,220 L280,232 C280,232.553 279.552,233 279,233 C278.448,233 278,232.553 278,232 L278,220 L278,220 Z M263,233 C263,235.209 264.791,237 267,237 L281,237 C283.209,237 285,235.209 285,233 L285,217 L263,217 L263,233 L263,233 Z M277,209 L271,209 L271,208 C271,207.447 271.448,207 272,207 L276,207 C276.552,207 277,207.447 277,208 L277,209 L277,209 Z M285,209 L279,209 L279,207 C279,205.896 278.104,205 277,205 L271,205 C269.896,205 269,205.896 269,207 L269,209 L263,209 C261.896,209 261,209.896 261,211 L261,213 C261,214.104 261.895,214.999 262.999,215 L285.002,215 C286.105,214.999 287,214.104 287,213 L287,211 C287,209.896 286.104,209 285,209 L285,209 Z" 
                            />
                        </g>
                    </g>
                </svg>
              ) : (
              <svg 
                xmlns="http://www.w3.org/2000/svg"
                className="h-5"
                viewBox="0 0 24 24" 
                fill="none" 
              >
                <path 
                  d="M4 12H20M12 4V20" 
                  className="stroke-white"
                  strokeWidth="3" 
                  strokeLinecap="round" 
                  strokeLinejoin="round"
                />
              </svg>
              )}
              <p
                className={cn(
                  "flex h-full items-center text-xl font-bold leading-none text-white/55 transition-all duration-200",
                  selected >= 0 && "group-hover:text-white",
                )}
              >
                {characters.current[selected].type === "character"
                  ? "Deletar"
                  : "Criar"}
              </p>
            </button>
          ) : (
            <p className="absolute bottom-14 left-14 text-xl font-semibold text-white/55">
              Selecione um personagem
            </p>
          )}
          <Characters />
          <Selected />
        </div>
      </main>
    </Background>
  );
}
