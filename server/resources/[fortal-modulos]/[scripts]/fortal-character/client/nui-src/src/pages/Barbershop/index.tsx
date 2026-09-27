import { useEffect, useRef } from "react";

import { Background } from "./components/Background";
import Camera from "./components/Camera";
import Field from "./components/Field";
import Filter from "./components/Filter";
import Footer from "./components/Footer";
import Hairstyles from "./components/Hairstyles";
import Header from "./components/Header";
import { Post } from "@/hooks/post";
import { useFilter } from "./stores/useFilter";
import { useHair } from "./stores/useHair";
import { usePartial } from "./stores/usePartial";
import { usePrice } from "./stores/usePrice";
import { useCamera } from "./stores/useCamera";

export default function Barbershop() {
  const hair = useHair();
  const price = usePrice();
  const partial = usePartial();
  const { current: filter } = useFilter();
  const { set: setCamera } = useCamera();

  const hairstyleAdded = useRef(false);
  const alteredPartials = useRef<Set<string>>(new Set());

  useEffect(() => {
    setCamera("fullbody")

    Post.create(
      "Barbershop:GetData",
      {
        filter,
      },
      {
        Hairstyles: [
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
          "https://media.discordapp.net/attachments/1038279017767383091/1392340987388493945/fe452392fa73dd63b8c833d7c302a57a75e5f24f.png?ex=686f2e17&is=686ddc97&hm=5e1b787b8842ab2729e587d2c993885dbaec1abdd7e28e67dee6482f9b18dc1c&=&format=webp&quality=lossless&width=164&height=134",
        ],
        CurrentHair: 4,
        Options: {
          makeup: {
            title: "Maquiagem",
            value: 1,
            min: 1,
            max: 33,
          },
          makeupcolor: {
            title: "Cor da Maquiagem",
            value: 1,
            min: 1,
            max: 33,
          },
          makeupcolor1: {
            title: "Cor da Maquiagem",
            value: 1,
            min: 1,
            max: 33,
          },
          makeupcolor2: {
            title: "Cor da Maquiagem",
            value: 1,
            min: 1,
            max: 33,
          },
          makeupcolor3: {
            title: "Cor da Maquiagem",
            value: 1,
            min: 1,
            max: 33,
          },
        },
      },
    ).then((data: any) => {
      hair.setOptions(data.Hairstyles || []);
      hair.setSelected(data.CurrentHair || 0);
      hair.setInitial(data.CurrentHair || 0);
      partial.set(data.Options || {});
    });
  }, [filter]);

  useEffect(() => {
    const isDifferent = hair.current.selected !== hair.current.initial;

    if (hair.current.edited && isDifferent && !hairstyleAdded.current) {
      hairstyleAdded.current = true;
    } else if (
      (!hair.current.edited || !isDifferent) &&
      hairstyleAdded.current
    ) {
      hairstyleAdded.current = false;
    }
  }, [hair.current]);

  useEffect(() => {
    price.set(0)
  }, [])

  useEffect(() => {
    const current = partial.current;
    const initial = partial.initial;

    const added: string[] = [];
    const removed: string[] = [];

    for (const [key, data] of Object.entries(current)) {
      const originalValue = initial[key]?.value;
      const isDifferent = data.value !== originalValue;

      if (isDifferent && !alteredPartials.current.has(key)) {
        alteredPartials.current.add(key);
        added.push(key);
      } else if (!isDifferent && alteredPartials.current.has(key)) {
        alteredPartials.current.delete(key);
        removed.push(key);
      }
    }
  }, [partial.current]);

  return (
    <Background>
      <aside className="relative flex items-center justify-center flex-none p-6 overflow-visible">
        <div className="absolute left-0 top-0 size-full bg-[#070916D9] blur-[50px]" />
        <Camera />
      </aside>
      <main className="flex h-screen w-full items-center justify-end overflow-visible pr-[3.69rem]">
        <div className="flex flex-col gap-1.5 overflow-visible">
          <Header />
          <div className="flex h-[45.4375rem] items-center gap-12">
            <div className="flex h-full w-[25.9375rem] flex-col gap-[1.12rem]">
              {filter === "hair" && <Hairstyles />}
              <ul className="scroll-hidden flex h-[37.0625rem] w-full flex-col gap-3.5 overflow-y-scroll">
                {Object.keys(partial.current).map((key) => {
                  if (key !== "hair") {
                    const char = partial.current[key];
                    return <Field key={key} descriminator={key} data={char} />;
                  }
                })}
              </ul>
            </div>
            <Filter />
          </div>
          <Footer />
        </div>
      </main>
    </Background>
  );
}
