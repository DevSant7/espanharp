import { Background } from "./components/Background";
import Camera from "./components/Camera";
import Filter from "./components/Filter";
import Footer from "./components/Footer";
import Header from "./components/Header";
import { Post } from "@/hooks/post";
import { cn } from "@/utils/misc";
import { useEffect } from "react";
import { useFilter } from "./stores/useFilter";
import { useTattoos, type Tattoos } from "./stores/useTattoos";
import { useCamera } from "./stores/useCamera";
import { usePrice } from "./stores/usePrice";

export default function Tattooshop() {
  const tattoos = useTattoos();
  const camera = useCamera();
  const price = usePrice();
  const { current: filter } = useFilter();

  useEffect(() => {
    price.set(0)
    camera.set("fullbody")

    Post.create<Tattoos>(
      "Tattoshop:GetTattoos",
      {},
      {
        head: [
          {
            id: 1,
            image:
              "https://media.discordapp.net/attachments/1197381474341634058/1382073935155167232/image_225.png?ex=6849d427&is=684882a7&hm=b9197db153c5cd8488cc82ebe73d34fce6952cd0e17255d47649e38158f5b984&=&format=webp&quality=lossless&width=110&height=110",
            price: 250,
            overlay: "1",
            collection: "2"
          },
          {
            id: 2,
            image:
              "https://media.discordapp.net/attachments/1197381474341634058/1382073935155167232/image_225.png?ex=6849d427&is=684882a7&hm=b9197db153c5cd8488cc82ebe73d34fce6952cd0e17255d47649e38158f5b984&=&format=webp&quality=lossless&width=110&height=110",
            price: 250,
            overlay: "1",
            collection: "2"
          },
        ],
      },
    ).then(tattoos.set);
  }, []);
  
  return (
    <Background>
      <aside className="relative flex flex-none items-center justify-center overflow-visible p-6">
        <div className="absolute left-0 top-0 size-full bg-[#070916D9] blur-[50px]" />
        <Camera />
      </aside>
      <main className="flex h-screen w-full items-center justify-end overflow-visible pr-[3.69rem]">
        <div className="flex flex-col gap-1.5 overflow-visible">
          <Header />
          <div className="flex h-[36.125rem] gap-12">
            <div className="scroll-hidden grid h-full w-[25.9375rem] grid-cols-4 gap-[0.31rem] overflow-y-scroll">
              {tattoos.current[filter] &&
                tattoos.current[filter].map((tat, index) => {
                  return (
                    <button
                      onClick={() => {
                        tattoos.setActive(filter, tat.id, !tat.active)

                        if (!tat.active === true) {
                          Post.create("Character:SetCamera", { section: "Tattooshop", id: tat.camera }).then((response) => {
                            if (response && tat.camera) camera.set(tat.camera)
                          })
                        }
                      }}
                      key={index}
                      className={cn(
                        "bg-section relative size-[6.25rem] flex-none rounded-md border",
                        tat.active ? "border-primary" : "border-white/15",
                      )}
                    >
                      <img
                        className="size-full"
                        src={tat.image}
                        draggable={false}
                        onError={(e) => {
                          e.currentTarget.style.display = "none";
                        }}
                      />
                      <div
                        className={cn(
                          "absolute left-1.5 top-1.5 grid size-[1.4375rem] place-items-center rounded text-[0.8125rem] font-medium leading-none text-white/90",
                          tat.active ? "bg-gradient-primary" : "bg-black/55",
                        )}
                      >
                        {index + 1}
                      </div>
                    </button>
                  );
                })}
            </div>
            <Filter />
          </div>
          <Footer />
        </div>
      </main>
    </Background>
  );
}
