import { Slider, SliderThumb, SliderTrack } from "@radix-ui/react-slider";
import { useEffect, useState } from "react";

import { Post } from "@/hooks/post";
import { cn } from "@/utils/misc";
import { useTattoos } from "../stores/useTattoos";
import { usePrice } from "../stores/usePrice";
import { usePopup } from "@/stores/usePopup"; 

export default function Footer() {
  const { set: setPopup } = usePopup();
  const { current: price } = usePrice();
  const tattoos = useTattoos();
  const actives = tattoos.getTotal();
  return (
    <footer className="flex w-[25.9375rem] flex-col gap-2 overflow-visible">
      <button
        onClick={() => {
          Post.create("Tattoshop:ClearTattoos");
          tattoos.clear();
        }}
        className="bg-section h-[2.875rem] w-full rounded border border-white/15 text-lg font-bold uppercase text-white hover:bg-white/10 active:scale-95 transition-all duration-200"
      >
        limpar tatuagens
      </button>
      <button
        onClick={() => {
          setPopup({
            title: "SALVAR TATUAGENS",
            description: `Tem certeza que deseja salvar suas tatuagens por $${price}?`,
            callback: () => Post.create("Tattooshop:SavePed", {
              price
            })
          })          
        }}
        disabled={price < 1 && actives > 0}
        className={cn(
          "bg-gradient-primary flex h-[2.875rem] w-full items-center justify-between rounded px-4 transition-all duration-200",
          price >= 1 && actives > 0 && "hover:opacity-80 active:scale-95",
        )}
      >
        <div className="flex items-center gap-3">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="w-4"
            viewBox="0 0 16 20"
            fill="none"
          >
            <path
              d="M0.583333 0.0860143C0.9375 -0.0663294 1.35417 -0.0116419 1.65 0.226639L3.33333 1.5782L5.01667 0.226639C5.39167 -0.0741419 5.94583 -0.0741419 6.31667 0.226639L8 1.5782L9.68333 0.226639C10.0583 -0.0741419 10.6125 -0.0741419 10.9833 0.226639L12.6667 1.5782L14.35 0.226639C14.6458 -0.0116419 15.0625 -0.0663294 15.4167 0.0860143C15.7708 0.238358 16 0.570389 16 0.937577V19.0626C16 19.4298 15.7708 19.7618 15.4167 19.9141C15.0625 20.0665 14.6458 20.0118 14.35 19.7735L12.6667 18.4219L10.9833 19.7735C10.6083 20.0743 10.0542 20.0743 9.68333 19.7735L8 18.4219L6.31667 19.7735C5.94167 20.0743 5.3875 20.0743 5.01667 19.7735L3.33333 18.4219L1.65 19.7735C1.35417 20.0118 0.9375 20.0665 0.583333 19.9141C0.229167 19.7618 0 19.4298 0 19.0626V0.937577C0 0.570389 0.229167 0.238358 0.583333 0.0860143ZM4 5.62508C3.63333 5.62508 3.33333 5.90633 3.33333 6.25008C3.33333 6.59383 3.63333 6.87508 4 6.87508H12C12.3667 6.87508 12.6667 6.59383 12.6667 6.25008C12.6667 5.90633 12.3667 5.62508 12 5.62508H4ZM3.33333 13.7501C3.33333 14.0938 3.63333 14.3751 4 14.3751H12C12.3667 14.3751 12.6667 14.0938 12.6667 13.7501C12.6667 13.4063 12.3667 13.1251 12 13.1251H4C3.63333 13.1251 3.33333 13.4063 3.33333 13.7501ZM4 9.37508C3.63333 9.37508 3.33333 9.65633 3.33333 10.0001C3.33333 10.3438 3.63333 10.6251 4 10.6251H12C12.3667 10.6251 12.6667 10.3438 12.6667 10.0001C12.6667 9.65633 12.3667 9.37508 12 9.37508H4Z"
              fill="white"
            />
          </svg>
          <p className="text-lg font-bold uppercase text-white">
            realizar tatuagens
          </p>
        </div>
        <p className="text-base font-semibold text-white/85">
          $ {price.toLocaleString("pt-br", { maximumFractionDigits: 0 })}
        </p>
      </button>
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
        className="relative flex h-[1.0625rem] w-full items-center overflow-visible transition-none duration-0"
        defaultValue={[direction]}
        onValueChange={([v]) => setDirection(v)}
        max={360}
        step={1}
      >
        <SliderTrack className="relative h-[0.4375rem] flex-grow rounded-full bg-white/15 transition-none duration-0" />
        <SliderThumb className="glow block size-[1.0625rem] rounded-full bg-primary transition-none duration-0" />
      </Slider>
    </div>
  );
}
