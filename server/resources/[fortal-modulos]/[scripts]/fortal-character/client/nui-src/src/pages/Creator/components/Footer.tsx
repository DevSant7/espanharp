import { Slider, SliderThumb, SliderTrack } from "@radix-ui/react-slider";
import { useEffect, useState } from "react";

import { useGenetics } from "../pages/Genetics/stores/useGenetics";
import { usePopup } from "@/stores/usePopup"; 
import { Post } from "@/hooks/post";
import { cn } from "@/utils/misc";
import { useNavigate } from "react-router-dom";

export default function Footer({
  canReturn,
  page,
  isSave,
  canClick,
}: {
  canReturn?: boolean;
  isSave?: boolean;
  canClick: boolean;
  page: string;
}) {
  const { set: setPopup } = usePopup();
  const genetics = useGenetics();
  const navigate = useNavigate();
  const returnPage = () => {
    navigate(-1);
  };
  const nextPage = () => {
    if (isSave) {
      setPopup({
        title: "SALVAR PERSONAGEM",
        description: `Tem certeza que deseja salvar o personagem ${genetics.current.name} ${genetics.current.surname} de ${genetics.current.age} anos?`,
        callback: () => Post.create("Creator:SaveCharacter")
      })
    } else {
      navigate(`/creator/${String(Number(page) + 1)}`);
    }
  };
  return (
    <footer className="flex w-full flex-col gap-2 overflow-visible">
      <div className="flex h-[2.875rem] w-full items-center gap-2">
        {canReturn && (
          <button
            onClick={returnPage}
            className="bg-section h-full w-[6.875rem] flex-none rounded border border-white/15 text-lg font-bold uppercase text-white hover:scale-95 hover:bg-white/10 hover:opacity-80 active:scale-90 transition-all duration-200"
          >
            voltar
          </button>
        )}
        <button
          onClick={nextPage}
          disabled={!canClick}
          className={cn(
            "bg-gradient-primary size-full rounded text-lg font-bold uppercase text-white transition-all duration-200",
            canClick
              ? "hover:scale-95 hover:opacity-80 active:scale-90"
              : "opacity-65",
          )}
        >
          {isSave ? "salvar" : "próximo"}
        </button>
      </div>
      <Rotate />
    </footer>
  );
}

function Rotate() {
  const [direction, setDirection] = useState<number>(180);
  useEffect(() => {
    Post.create("Character:RotatePed", { direction });
  }, [direction]);
  return (
    <div className="bg-section flex h-[2.5625rem] w-full items-center rounded border border-white/5 pr-[1.13rem]">
      <p className="grid h-full w-20 flex-none place-items-center font-bold leading-none text-white/90">
        {direction}°
      </p>
      <Slider
        className="relative flex h-[0.8125rem] w-full items-center overflow-visible transition-none duration-0"
        defaultValue={[direction]}
        onValueChange={([v]) => setDirection(v)}
        max={360}
        step={1}
      >
        <SliderTrack className="relative h-[0.3125rem] flex-grow rounded-full bg-white/15 transition-none duration-0" />
        <SliderThumb className="glow block size-[0.8125rem] rounded-full bg-primary transition-none duration-0" />
      </Slider>
    </div>
  );
}
