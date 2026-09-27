import { Slider, SliderThumb, SliderTrack } from "@radix-ui/react-slider";
import { useEffect, useState } from "react";

import { Post } from "@/hooks/post";
import { cn } from "@/utils/misc";
import { useClothes } from "../stores/useClothes";
import { useFilter } from "../stores/useFilter";
import { usePrice } from "../stores/usePrice";
import { usePopup } from "@/stores/usePopup";

export default function Footer({ inCreator }: { inCreator: boolean }) {
  const { current: filter } = useFilter();
  const { current: price } = usePrice();
  const { set: setPopup } = usePopup();
  const clothes = useClothes();
  const actives = clothes.getTotal();
  const activeIndex = clothes.getActive(filter)
    ? (clothes.getActive(filter) as any).index + 1
    : undefined;
  const activeItem = clothes.getActive(filter)
    ? (clothes.getActive(filter) as any).item
    : undefined;
  return (
    <footer className="flex w-[25.9375rem] flex-col gap-2 overflow-visible">
      {clothes.getActive(filter) && (
        <div className="bg-section flex h-[3.4375rem] w-full items-center justify-between gap-[0.44rem] rounded-md border border-white/15 px-2">
          <div className="flex w-full items-center gap-[0.44rem] overflow-visible">
            <div className="glow bg-gradient-primary grid size-[2.4375rem] place-items-center rounded">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="size-[1.6875rem]"
                viewBox="0 0 27 27"
                fill="none"
              >
                <path
                  d="M2.22652 0.0324745C1.08751 0.244444 0.204773 1.1461 0.0275937 2.28188C0.00228232 2.45272 -0.00404551 5.44559 0.00228232 13.6649C0.0117741 24.3203 0.014938 24.8265 0.0687246 25.0069C0.236412 25.5605 0.597099 26.1047 1.01157 26.4274C1.28051 26.6393 1.72029 26.8576 2.03668 26.9431C2.24866 26.9968 2.68845 27 13.5217 27C24.2822 27 24.7947 26.9968 24.9909 26.9431C25.3041 26.8545 25.804 26.5982 26.0413 26.4021C26.1552 26.3071 26.3261 26.1395 26.4147 26.0287C26.6013 25.801 26.8576 25.2948 26.9431 24.991C26.9968 24.7949 27 24.2824 27 13.5226C27 2.6552 26.9968 2.2534 26.9399 2.03827C26.8545 1.71241 26.6393 1.27898 26.4305 1.01639C26.0635 0.544996 25.4687 0.178005 24.8865 0.057785C24.6049 0.000837326 24.279 -0.00232697 13.4901 0.000837326C6.85533 0.00400162 2.32143 0.016655 2.22652 0.0324745ZM7.35207 7.3375L2.73274 11.9565L2.72325 8.69157L2.71692 5.42345L4.06792 4.07254L5.42207 2.71847H8.69673H11.9714L7.35207 7.3375ZM12.5567 12.5418L2.73274 22.3652L2.72325 19.1002L2.71692 15.8321L9.27256 9.27686L15.8314 2.71847H19.106H22.3807L12.5567 12.5418ZM17.7392 17.7366L11.1804 24.295H7.90575H4.63109L14.4551 14.4717L24.279 4.64834L24.2885 7.91329L24.2948 11.1814L17.7392 17.7366ZM22.9439 22.941L21.5897 24.295H18.315H15.0404L19.6597 19.676L24.279 15.057L24.2885 18.3219L24.2948 21.59L22.9439 22.941Z"
                  fill="white"
                />
              </svg>
            </div>
            <div className="flex h-[2.4375rem] items-center gap-[0.315rem]">
              <button
                onClick={() => clothes.decrementTexture(filter)}
                className="bg-section group grid size-[2.4375rem] place-items-center rounded border border-white/15 hover:bg-white/15 active:scale-95 transition-all duration-200"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-4 opacity-75 group-hover:opacity-100 transition-all duration-200"
                  viewBox="0 0 9 15"
                  fill="none"
                >
                  <path
                    d="M0.523959 8.10104C0.192014 7.7691 0.192014 7.2309 0.523959 6.89896L5.93333 1.48959C6.26527 1.15765 6.80346 1.15765 7.13541 1.48959C7.46735 1.82154 7.46735 2.35973 7.13541 2.69167L2.32708 7.5L7.13541 12.3083C7.46735 12.6403 7.46735 13.1785 7.13541 13.5104C6.80346 13.8424 6.26527 13.8424 5.93333 13.5104L0.523959 8.10104ZM2.25 7.5V8.35H1.125V7.5V6.65H2.25V7.5Z"
                    fill="white"
                  />
                </svg>
              </button>
              <div className="bg-section grid h-full w-[7.19381rem] place-items-center rounded border border-white/15">
                <p className="text-[0.9375rem] font-medium leading-none text-white">
                  {activeItem.texture.selected > 0
                    ? String(activeItem.texture.selected).padStart(2, "0")
                    : activeItem.texture.selected}
                  <span className="opacity-85">
                    /{String(activeItem.texture.options).padStart(2, "0")}
                  </span>
                </p>
              </div>
              <button
                onClick={() => clothes.incrementTexture(filter)}
                className="bg-section group grid size-[2.4375rem] place-items-center rounded border border-white/15 hover:bg-white/15 active:scale-95 transition-all duration-200"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  className="h-4 opacity-75 group-hover:opacity-100 transition-all duration-200"
                  viewBox="0 0 9 15"
                  fill="none"
                >
                  <path
                    d="M8.47604 8.10104C8.80799 7.7691 8.80799 7.2309 8.47604 6.89896L3.06667 1.48959C2.73473 1.15765 2.19654 1.15765 1.86459 1.48959C1.53265 1.82154 1.53265 2.35973 1.86459 2.69167L6.67292 7.5L1.86459 12.3083C1.53265 12.6403 1.53265 13.1785 1.86459 13.5104C2.19654 13.8424 2.73473 13.8424 3.06667 13.5104L8.47604 8.10104ZM6.75 7.5V8.35H7.875V7.5V6.65H6.75V7.5Z"
                    fill="white"
                  />
                </svg>
              </button>
            </div>
          </div>
          <h1 className="grid h-[2.4375rem] w-[8.9375rem] flex-none place-items-center text-lg font-medium leading-none text-white/75">
            {activeIndex}
          </h1>
        </div>
      )}
      <button
        onClick={() => {
          setPopup({
            title: "SALVAR ROUPAS",
            description: `Tem certeza que deseja salvar suas roupas${!inCreator ? ` por $${price}` : ""}?`,
            callback: () => Post.create("Skinshop:SavePed", {
              clothes: clothes.current,
              price,
            })
          })
        }}
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
            {inCreator ? "salvar" : "comprar"}{" "}roupas
          </p>
        </div>
        {!inCreator &&
          <p className="text-base font-semibold text-white/85">
            $ {price.toLocaleString("pt-br", { maximumFractionDigits: 0 })}
          </p>
        }
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
