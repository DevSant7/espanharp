import { useEffect, useState } from "react";
import { FixedSizeGrid as Grid } from 'react-window';

import { Background } from "./components/Background";
import Camera from "./components/Camera";
import Filter from "./components/Filter";
import { Filters } from "./filters";
import Footer from "./components/Footer";
import Header from "./components/Header";
import { Post } from "@/hooks/post";
import { listen } from "@/hooks/listen";
import { cn } from "@/utils/misc";
import { useClothes, type Clothes } from "./stores/useClothes";
import { useFilter } from "./stores/useFilter";
import { useCamera } from "./stores/useCamera";
import { usePrice } from "./stores/usePrice";

export default function Skinshop() {
  const [page, setPage] = useState<string>("1");
  const [inCreator, setInCreator] = useState<boolean>(false)
  const clothes = useClothes();
  const { current: filter, set: setFilter } = useFilter();
  const { set: setCamera } = useCamera(); 
  const { set: setPrice } = usePrice();

  useEffect(() => {
    setCamera("fullbody")
    setPrice(0)

    Post.create<boolean>(
      "Skinshop:GetInCreator"
    ).then(setInCreator)

    Post.create<Clothes>(
      "Skinshop:GetClothes",
      {},
      {
        hat: [
          {
            id: 1,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/1.webp",
            active: true,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 2,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/372189.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 3,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/3.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 4,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/4.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 5,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/5.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 6,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/6.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 7,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/7.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
          {
            id: 9,
            image:
              "http://127.0.0.1/character/skinshop/hat/m/8.webp",
            active: false,
            texture: {
              selected: 0,
              options: 30,
            },
          },
        ],
      },
    ).then(clothes.set);
  }, []);

  useEffect(() => {
    const currentFilter = Filters[page];
    setFilter(currentFilter[0]);
  }, [page]);

  listen<KeyboardEvent>("keydown", (e) => {
    const active = clothes.getActive(filter);

    if (!active) return;

    if (["ArrowRight"].includes(e.code)) {
      if ((active.index + 2) <= clothes.current[filter].length) {
        clothes.setActive(filter, active.index + 1, true)
      }
    } else if (["ArrowLeft"].includes(e.code)) {
      if (active.index - 1 >= 0) {
        clothes.setActive(filter, active.index - 1, true)
      }
    }
  });
  
  return (
    <Background>
      <aside className="relative flex flex-none items-center justify-center overflow-visible p-6">
        <div className="absolute left-0 top-0 size-full bg-[#070916D9] blur-[50px]" />
        <Camera />
      </aside>
      <main className="flex h-screen w-full items-center justify-end gap-[2.87rem] overflow-visible pr-14">
        <div className="flex flex-col gap-1.5 overflow-visible">
          <Header page={page} />
          <div className="flex h-[40rem] gap-12">
            <div className="scroll-hidden h-full w-[25.9375rem] gap-[0.31rem] overflow-y-scroll">
              {clothes.current[filter] &&
                <Grid
                  columnCount={4}
                  columnWidth={104}
                  height={1050}
                  rowCount={Math.ceil(clothes.current[filter].length / 4)}
                  rowHeight={105}
                  width={450}
                >
                  {({ columnIndex, rowIndex, style }: { columnIndex: number; rowIndex: number; style: any }) => {
                    const index = rowIndex * 4 + columnIndex;
                    const clothe = clothes.current[filter][index]
                    
                    if (clothe) return (
                      <div
                        key={index}
                        style={{
                          ...style,
                          display: "flex",
                          justifyContent: "center",
                          alignItems: "flex-start",
                          boxSizing: "border-box", 
                        }}
                      >
                        <button
                          onClick={() => {
                            clothes.setActive(filter, clothe.id, true)
                            if (clothe.camera) Post.create("Character:SetCamera", { section: "Skinshop", id: clothe.camera }).then((response) => {
                              if (response && clothe.camera) setCamera(clothe.camera)
                            })
                          }}
                          key={index}
                          disabled={clothe.active}
                          className={cn(
                            "relative size-[6.25rem] flex-none place-items-center rounded-md border",
                            clothe.active
                              ? "bg-gradient-primary border-primary"
                              : "bg-section border-white/15",
                          )}
                        >
                          <img
                            className="size-full"
                            src={clothe.image}
                            draggable={false}
                            loading="lazy"
                            onError={(event) => {
                              event.currentTarget.src = "http://127.0.0.1/character/skinshop/none.png";
                            }}
                          />
                          <div className="absolute left-2 top-1.5 grid place-items-center rounded text-[0.8125rem] font-medium leading-none text-white/90">
                            {index + 1}
                          </div>
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            className={cn(
                              "absolute right-2 top-2 size-4",
                              !clothe.active && "opacity-0",
                            )}
                            viewBox="0 0 16 16"
                            fill="none"
                          >
                            <path
                              d="M8 0C10.1217 0 12.1566 0.842855 13.6569 2.34315C15.1571 3.84344 16 5.87827 16 8C16 10.1217 15.1571 12.1566 13.6569 13.6569C12.1566 15.1571 10.1217 16 8 16C5.87827 16 3.84344 15.1571 2.34315 13.6569C0.842855 12.1566 0 10.1217 0 8C0 5.87827 0.842855 3.84344 2.34315 2.34315C3.84344 0.842855 5.87827 0 8 0ZM7.00343 9.57829L5.22629 7.8C5.16258 7.73629 5.08694 7.68575 5.0037 7.65127C4.92046 7.61679 4.83124 7.59905 4.74114 7.59905C4.65104 7.59905 4.56183 7.61679 4.47859 7.65127C4.39534 7.68575 4.31971 7.73629 4.256 7.8C4.12733 7.92867 4.05505 8.10318 4.05505 8.28514C4.05505 8.46711 4.12733 8.64162 4.256 8.77029L6.51886 11.0331C6.58239 11.0972 6.65796 11.148 6.74123 11.1827C6.82449 11.2174 6.9138 11.2352 7.004 11.2352C7.0942 11.2352 7.18351 11.2174 7.26677 11.1827C7.35004 11.148 7.42561 11.0972 7.48914 11.0331L12.1749 6.34629C12.2394 6.28284 12.2908 6.20724 12.326 6.12385C12.3612 6.04045 12.3795 5.95091 12.3799 5.8604C12.3804 5.76988 12.3629 5.68017 12.3284 5.59646C12.294 5.51274 12.2434 5.43666 12.1794 5.37262C12.1154 5.30858 12.0394 5.25783 11.9557 5.22331C11.872 5.18879 11.7824 5.17118 11.6918 5.1715C11.6013 5.17181 11.5118 5.19004 11.4283 5.22514C11.3449 5.26024 11.2692 5.31151 11.2057 5.376L7.00343 9.57829Z"
                              fill="white"
                            />
                          </svg>
                        </button>
                      </div>
                    )
                  }}
                </Grid>
              }
            </div>
          </div>
          <Footer inCreator={inCreator} />
        </div>
        <div className="h-screen pt-[13.94rem]">
          <Filter page={page} setPage={setPage} />
        </div>
      </main>
    </Background>
  );
}
