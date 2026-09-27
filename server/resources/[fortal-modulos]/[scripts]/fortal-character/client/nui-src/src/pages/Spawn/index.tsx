import { useEffect } from "react";
import { useLocations, type Location } from "./stores/useLocations";
import { Cell } from "./components/Cell";
import { cn } from "@/utils/misc";
import { Post } from "@/hooks/post";
import ServerLogo from "@/public/logo.png";
import BlurBgfrom from "@/public/blur.png";

export default function Spawn() {
    const { current: locations, set: setLocations } = useLocations();

    useEffect(() => {
        Post.create<Location[]>("Spawn:GetLocations", {}, [
            {
                id: "policedepartament",
                name: "DEPARTAMENTO POLICIAL",
                image: ""
            },
            {
                id: "hospital",
                name: "HOSPITAL PILLBOX",
                image: ""
            },
            {
                id: "parkgarage",
                name: "GARAGEM PRAÇA",
                image: ""
            },
            {
                id: "delperropier",
                name: "DEL PERRO PIER",
                image: ""
            }
        ]).then(setLocations)
    }, [])

    return (
        <main className="flex flex-col items-center justify-start h-screen">
          <img 
            src={BlurBgfrom}
            alt="Blur Background"
            className="absolute w-full h-full"
          />

          <img
            src={ServerLogo}
            alt="Server Logo"
            className="size-[9.625rem] z-10"
          />

          <div className="flex flex-col w-full items-center z-10 mt-[3.5rem] gap-[6.69rem]">
            <div className="flex gap-[1.19rem]">
              {locations.map((data, index) => (
                  <Cell 
                    key={index}
                    data={data}
                    index={index} 
                  />
              ))}
            </div>

            <div className="flex flex-col items-center gap-8">
              <button
                onClick={() => Post.create("Spawn:LastLocation")}
                className={cn(
                  "grid place-items-center h-[2.6875rem] w-fit p-2.5",
                  "border-[1px] border-solid border-white/10 rounded-md",
                  "bg-[radial-gradient(95.47%_60.03%_at_49.84%_76.67%,_rgba(255,_255,_255,_0.06)_0%,_rgba(255,_255,_255,_0.00)_100%),_linear-gradient(91deg,_rgba(255,_255,_255,_0.01)_0%,_rgba(255,_255,_255,_0.01)_100%)]",
                  "text-white text-center text-lg font-bold leading-[normal]",
                  "hover:border-white/30 transition-all duration-300"
                )}
              >
                ULTIMA LOCALIZAÇÃO
              </button>
              <h1 className="text-white/60 text-sm font-medium leading-[normal]">
                Clique aqui para retornar à sua última localização salva na cidade.
              </h1>
            </div>
          </div>
        </main>
    )
}