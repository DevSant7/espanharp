import { Slider, SliderThumb, SliderTrack } from "@radix-ui/react-slider";
import { useEffect, useState } from "react";

import Footer from "../../components/Footer";
import { GeneralIcons } from "@/components/Icons";
import Header from "../../components/Header";
import { Post } from "@/hooks/post";
import { cn } from "@/utils/misc";
import { useGenetics } from "./stores/useGenetics";
import { useParents, type Parents } from "./stores/useParents";
import { useSave } from "../../stores/useSave";

export default function Genetics() {
  const save = useSave();
  const genetics = useGenetics();
  const parents = useParents();
  const [showParentOptions, setShowParentOptions] = useState<string | false>(
    false,
  );
  const { current: data } = genetics;

  useEffect(() => {
    Post.create<Parents>("Creator:GetParents").then(parents.set)
  }, [])

  useEffect(() => {
    save.set(
      data.name.length > 1 &&
        data.surname.length > 1 &&
        !isNaN(Number(data.age)) &&
        Number(data.age) >= 18,
    );
    Post.create("Creator:UpdatePedPreview", { section: "genetics", data });
  }, [data]);
  const parentOptions = showParentOptions
    ? showParentOptions == "Mothers"
      ? parents.current.mothers
      : parents.current.fathers
    : [];
  return (
    <div className="flex size-full items-center justify-between overflow-visible pr-16">
      <div className="flex w-[20.125rem] flex-col items-center overflow-visible">
        <Header />
        <ul className="scroll-hidden mb-2 mt-6 flex h-[37.0625rem] w-full flex-col gap-5 overflow-y-scroll">
          <p className="flex-none text-base font-bold text-white/65">Dados</p>
          <div className="flex w-full flex-none flex-col gap-2">
            <input
              className="bg-section h-12 rounded border border-white/15 bg-transparent px-4 text-base font-medium text-white placeholder:text-white/65 capitalize"
              type="text"
              maxLength={16}
              value={data.name}
              placeholder="Nome"
              onChange={({ target }) => {
                const onlyLetters = target.value.replace(/[^a-zA-Z]/g, "");
                const formatted = onlyLetters.charAt(0).toUpperCase() + onlyLetters.slice(1).toLowerCase();
                genetics.setName(formatted);              
              }}
            />
            <input
              className="bg-section h-12 rounded border border-white/15 bg-transparent px-4 text-base font-medium text-white placeholder:text-white/65 capitalize"
              type="text"
              maxLength={16}
              value={data.surname}
              placeholder="Sobrenome"
              onChange={({ target }) => {
                const onlyLetters = target.value.replace(/[^a-zA-Z]/g, "");
                const formatted = onlyLetters.charAt(0).toUpperCase() + onlyLetters.slice(1).toLowerCase();
                genetics.setSurname(formatted);              
              }}            />
            <div className="bg-section flex h-12 items-center gap-2 rounded border border-white/15 pr-2 text-base font-medium text-white">
              <input
                className="size-full bg-transparent px-4 text-base font-medium text-white placeholder:text-white/65"
                type="number"
                value={data.age}
                placeholder="Idade"
                onChange={({ target }) => {
                  const { value } = target;

                  if (!isNaN(Number(value)) || value.length < 1) {
                    if (Number(value) > 60) {
                      genetics.setAge("60");
                    } else genetics.setAge(value);
                  }
                }}
              />
              <div className="bg-gradient-primary glow flex h-[2.125rem] flex-none items-center rounded px-2.5 font-bold leading-none">
                18-60
              </div>
            </div>
          </div>
          <p className="flex-none text-base font-bold text-white/65">Gênero</p>
          <div className="flex h-[3.125rem] w-full flex-none items-center gap-1.5 overflow-visible">
            <button
              onClick={() => {
                genetics.setGender("m")
                Post.create("Creator:ChangeGender", { gender: "m" })
              }}
              className={cn(
                "flex size-full items-center justify-center gap-2 rounded border border-white/15",
                data.gender == "m" ? "bg-gradient-primary" : "bg-section",
              )}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="size-4"
                viewBox="0 0 15 15"
                fill="none"
              >
                <path
                  d="M15 0V5.38288H13.2207V3.06306L9.43694 6.82432C9.72222 7.27478 9.94369 7.75525 10.1014 8.26577C10.259 8.77628 10.3378 9.29429 10.3378 9.81982C10.3378 11.2613 9.83859 12.485 8.84009 13.491C7.84159 14.497 6.62162 15 5.18018 15C3.73874 15 2.51501 14.497 1.50901 13.491C0.503003 12.485 0 11.2613 0 9.81982C0 8.37838 0.503003 7.15465 1.50901 6.14865C2.51501 5.14264 3.73874 4.63964 5.18018 4.63964C5.72072 4.63964 6.23874 4.72222 6.73423 4.88739C7.22973 5.05255 7.69519 5.28529 8.13063 5.58559L11.9369 1.77928H9.61712V0H15ZM5.18018 6.44144C4.23423 6.44144 3.43093 6.76802 2.77027 7.42117C2.10961 8.07432 1.77928 8.87387 1.77928 9.81982C1.77928 10.7658 2.10961 11.5653 2.77027 12.2185C3.43093 12.8716 4.22673 13.1982 5.15766 13.1982C6.1036 13.1982 6.90691 12.8716 7.56757 12.2185C8.22823 11.5653 8.55856 10.7658 8.55856 9.81982C8.55856 8.87387 8.23198 8.07432 7.57883 7.42117C6.92567 6.76802 6.12613 6.44144 5.18018 6.44144V6.44144Z"
                  fill="white"
                />
              </svg>
              <p className="text-lg font-bold text-white">Masculino</p>
            </button>
            <button
              onClick={() => {
                genetics.setGender("f")
                Post.create("Creator:ChangeGender", { gender: "f" })
              }}              
              className={cn(
                "flex size-full items-center justify-center gap-2 rounded border border-white/15",
                data.gender == "f" ? "bg-gradient-primary" : "bg-section",
              )}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-4"
                viewBox="0 0 10 15"
                fill="none"
              >
                <path
                  d="M4.13043 15V13.3003H2.3913V11.6856H4.13043V9.66714C2.94203 9.483 1.95652 8.93414 1.17391 8.02054C0.391304 7.10694 0 6.06232 0 4.88669C0 3.52691 0.48913 2.37252 1.46739 1.42351C2.44565 0.474504 3.62319 0 5 0C6.37681 0 7.55435 0.474504 8.53261 1.42351C9.51087 2.37252 10 3.52691 10 4.88669C10 6.06232 9.60869 7.10694 8.82609 8.02054C8.04348 8.93414 7.05797 9.483 5.86956 9.66714V11.6856H7.6087V13.3003H5.86956V15H4.13043ZM5 8.07366C5.91304 8.07366 6.68478 7.76558 7.31522 7.14943C7.94565 6.53329 8.26087 5.77904 8.26087 4.88669C8.26087 3.99433 7.94565 3.24009 7.31522 2.62394C6.68478 2.00779 5.91304 1.69972 5 1.69972C4.08696 1.69972 3.31522 2.00779 2.68478 2.62394C2.05435 3.24009 1.73913 3.99433 1.73913 4.88669C1.73913 5.77904 2.05435 6.53329 2.68478 7.14943C3.31522 7.76558 4.08696 8.07366 5 8.07366V8.07366Z"
                  fill="white"
                />
              </svg>
              <p className="text-lg font-bold text-white">Feminino</p>
            </button>
          </div>
          <p className="flex-none text-base font-bold text-white/65">
            Parentesco
          </p>
          {(parents.current.fathers[data.father] && parents.current.mothers[data.mother]) &&
            <>
              <div className="flex h-[4.25rem] w-full flex-none flex-col gap-3">
                <div className="flex gap-4">
                  <button
                    onClick={() =>
                      setShowParentOptions(
                        showParentOptions == "Fathers" ? false : "Fathers",
                      )
                    }
                    className="bg-section relative grid size-[4.25rem] flex-none place-items-center rounded-md border border-white/15 hover:bg-white/15 transition-all duration-200"
                  >
                    <img
                      className="size-full"
                      src={parents.current.fathers[data.father].image}
                      draggable={false}
                    />
                    {showParentOptions && showParentOptions == "Fathers" && (
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="absolute size-[1.3125rem]"
                        viewBox="0 0 21 21"
                        fill="none"
                      >
                        <path
                          d="M10.5 0C13.2848 0 15.9555 1.10625 17.9246 3.07538C19.8938 5.04451 21 7.71523 21 10.5C21 13.2848 19.8938 15.9555 17.9246 17.9246C15.9555 19.8938 13.2848 21 10.5 21C7.71523 21 5.04451 19.8938 3.07538 17.9246C1.10625 15.9555 0 13.2848 0 10.5C0 7.71523 1.10625 5.04451 3.07538 3.07538C5.04451 1.10625 7.71523 0 10.5 0ZM9.192 12.5715L6.8595 10.2375C6.77588 10.1539 6.67661 10.0876 6.56736 10.0423C6.4581 9.99704 6.34101 9.97375 6.22275 9.97375C6.10449 9.97375 5.9874 9.99704 5.87814 10.0423C5.76889 10.0876 5.66962 10.1539 5.586 10.2375C5.41712 10.4064 5.32225 10.6354 5.32225 10.8743C5.32225 11.1131 5.41712 11.3421 5.586 11.511L8.556 14.481C8.63938 14.565 8.73857 14.6317 8.84786 14.6773C8.95715 14.7228 9.07436 14.7462 9.19275 14.7462C9.31114 14.7462 9.42835 14.7228 9.53764 14.6773C9.64693 14.6317 9.74612 14.565 9.8295 14.481L15.9795 8.3295C16.0642 8.24623 16.1316 8.147 16.1778 8.03755C16.224 7.92809 16.2481 7.81057 16.2487 7.69177C16.2492 7.57297 16.2262 7.45523 16.1811 7.34535C16.1359 7.23547 16.0694 7.13562 15.9854 7.05156C15.9015 6.96751 15.8017 6.9009 15.6919 6.8556C15.5821 6.81029 15.4644 6.78718 15.3455 6.78759C15.2267 6.788 15.1092 6.81193 14.9997 6.858C14.8902 6.90407 14.7909 6.97136 14.7075 7.056L9.192 12.5715Z"
                          fill="white"
                        />
                      </svg>
                    )}
                  </button>
                  <div className="flex size-full flex-col">
                    <p className="flex h-full items-center text-base font-bold text-white/85">
                      Pai
                    </p>
                    <div className="bg-section flex h-[2.625rem] w-full flex-none items-center justify-between gap-2 rounded border border-white/15 p-1.5">
                      <button
                        onClick={() => {
                          if (data.father - 1 >= 0) {
                            genetics.setFather(data.father - 1);
                          }
                        }}
                        className="grid size-[1.875rem] flex-none place-items-center rounded bg-white/15 hover:bg-white/20 active:scale-95 transition-all duration-200"
                      >
                        <GeneralIcons.ChevronLeft />
                      </button>
                      <p className="w-full truncate text-center text-base font-bold text-white/85 capitalize">
                        {parents.current.fathers[data.father].name}
                      </p>
                      <button
                        className="grid size-[1.875rem] flex-none place-items-center rounded bg-white/15 hover:bg-white/20 active:scale-95 transition-all duration-200"
                        onClick={() => {
                          if (data.father + 1 < parents.current.fathers.length) {
                            genetics.setFather(data.father + 1);
                          }
                        }}
                      >
                        <GeneralIcons.ChevronRight />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div className="flex h-[4.25rem] w-full flex-none flex-col gap-3">
                <div className="flex gap-4">
                  <button
                    onClick={() =>
                      setShowParentOptions(
                        showParentOptions == "Mothers" ? false : "Mothers",
                      )
                    }
                    className="bg-section relative grid size-[4.25rem] flex-none place-items-center rounded-md border border-white/15 hover:bg-white/15 transition-all duration-200"
                  >
                    <img
                      className="size-full"
                      src={parents.current.mothers[data.mother].image}
                      draggable={false}
                    />
                    {showParentOptions && showParentOptions == "Mothers" && (
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="absolute size-[1.3125rem]"
                        viewBox="0 0 21 21"
                        fill="none"
                      >
                        <path
                          d="M10.5 0C13.2848 0 15.9555 1.10625 17.9246 3.07538C19.8938 5.04451 21 7.71523 21 10.5C21 13.2848 19.8938 15.9555 17.9246 17.9246C15.9555 19.8938 13.2848 21 10.5 21C7.71523 21 5.04451 19.8938 3.07538 17.9246C1.10625 15.9555 0 13.2848 0 10.5C0 7.71523 1.10625 5.04451 3.07538 3.07538C5.04451 1.10625 7.71523 0 10.5 0ZM9.192 12.5715L6.8595 10.2375C6.77588 10.1539 6.67661 10.0876 6.56736 10.0423C6.4581 9.99704 6.34101 9.97375 6.22275 9.97375C6.10449 9.97375 5.9874 9.99704 5.87814 10.0423C5.76889 10.0876 5.66962 10.1539 5.586 10.2375C5.41712 10.4064 5.32225 10.6354 5.32225 10.8743C5.32225 11.1131 5.41712 11.3421 5.586 11.511L8.556 14.481C8.63938 14.565 8.73857 14.6317 8.84786 14.6773C8.95715 14.7228 9.07436 14.7462 9.19275 14.7462C9.31114 14.7462 9.42835 14.7228 9.53764 14.6773C9.64693 14.6317 9.74612 14.565 9.8295 14.481L15.9795 8.3295C16.0642 8.24623 16.1316 8.147 16.1778 8.03755C16.224 7.92809 16.2481 7.81057 16.2487 7.69177C16.2492 7.57297 16.2262 7.45523 16.1811 7.34535C16.1359 7.23547 16.0694 7.13562 15.9854 7.05156C15.9015 6.96751 15.8017 6.9009 15.6919 6.8556C15.5821 6.81029 15.4644 6.78718 15.3455 6.78759C15.2267 6.788 15.1092 6.81193 14.9997 6.858C14.8902 6.90407 14.7909 6.97136 14.7075 7.056L9.192 12.5715Z"
                          fill="white"
                        />
                      </svg>
                    )}
                  </button>
                  <div className="flex size-full flex-col">
                    <p className="flex h-full items-center text-base font-bold text-white/85">
                      Mãe
                    </p>
                    <div className="bg-section flex h-[2.625rem] w-full flex-none items-center justify-between gap-2 rounded border border-white/15 p-1.5">
                      <button
                        onClick={() => {
                          if (data.mother - 1 >= 0) {
                            genetics.setMother(data.mother - 1);
                          }
                        }}
                        className="grid size-[1.875rem] flex-none place-items-center rounded bg-white/15 hover:bg-white/20 active:scale-95 transition-all duration-200"
                      >
                        <GeneralIcons.ChevronLeft />
                      </button>
                      <p className="w-full truncate text-center text-base font-bold text-white/85 capitalize">
                        {parents.current.mothers[data.mother].name}
                      </p>
                      <button
                        className="grid size-[1.875rem] flex-none place-items-center rounded bg-white/15 hover:bg-white/20 active:scale-95 transition-all duration-200"
                        onClick={() => {
                          if (data.mother + 1 < parents.current.mothers.length) {
                            genetics.setMother(data.mother + 1);
                          }
                        }}
                      >
                        <GeneralIcons.ChevronRight />
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </>
          }
          <p className="flex-none text-base font-bold text-white/65">
            Semelhança
          </p>
          <div className="bg-section flex h-[2.5625rem] w-full flex-none items-center rounded border border-white/5 pr-[1.13rem]">
            <div className="flex h-full w-20 flex-none items-center justify-center gap-2">
              <p className="mt-0.5 flex h-full flex-none items-center font-bold leading-none text-white/90">
                {data.paternity}%
              </p>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="size-4"
                viewBox="0 0 15 15"
                fill="none"
              >
                <path
                  d="M15 0V5.38288H13.2207V3.06306L9.43694 6.82432C9.72222 7.27478 9.94369 7.75525 10.1014 8.26577C10.259 8.77628 10.3378 9.29429 10.3378 9.81982C10.3378 11.2613 9.83859 12.485 8.84009 13.491C7.84159 14.497 6.62162 15 5.18018 15C3.73874 15 2.51501 14.497 1.50901 13.491C0.503003 12.485 0 11.2613 0 9.81982C0 8.37838 0.503003 7.15465 1.50901 6.14865C2.51501 5.14264 3.73874 4.63964 5.18018 4.63964C5.72072 4.63964 6.23874 4.72222 6.73423 4.88739C7.22973 5.05255 7.69519 5.28529 8.13063 5.58559L11.9369 1.77928H9.61712V0H15ZM5.18018 6.44144C4.23423 6.44144 3.43093 6.76802 2.77027 7.42117C2.10961 8.07432 1.77928 8.87387 1.77928 9.81982C1.77928 10.7658 2.10961 11.5653 2.77027 12.2185C3.43093 12.8716 4.22673 13.1982 5.15766 13.1982C6.1036 13.1982 6.90691 12.8716 7.56757 12.2185C8.22823 11.5653 8.55856 10.7658 8.55856 9.81982C8.55856 8.87387 8.23198 8.07432 7.57883 7.42117C6.92567 6.76802 6.12613 6.44144 5.18018 6.44144V6.44144Z"
                  className="fill-[#df5454]"
                />
              </svg>
            </div>
            <Slider
              className="relative flex h-[0.8125rem] w-full items-center overflow-visible transition-none duration-0"
              defaultValue={[data.paternity]}
              onValueChange={([v]) => genetics.setPaternity(v)}
              max={100}
              step={1}
            >
              <SliderTrack className="relative h-[0.3125rem] flex-grow rounded-full bg-white/15 transition-none duration-0" />
              <SliderThumb className="glow block size-[0.8125rem] rounded-full bg-primary transition-none duration-0" />
            </Slider>
            <div className="flex h-full w-20 flex-none items-center justify-center gap-2">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-4"
                viewBox="0 0 11 16"
                fill="none"
              >
                <path
                  d="M4.54348 16V14.187H2.63043V12.4646H4.54348V10.3116C3.23623 10.1152 2.15217 9.52975 1.2913 8.55524C0.430435 7.58074 0 6.46648 0 5.21246C0 3.76204 0.538043 2.53069 1.61413 1.51841C2.69022 0.506138 3.98551 0 5.5 0C7.01449 0 8.30978 0.506138 9.38587 1.51841C10.462 2.53069 11 3.76204 11 5.21246C11 6.46648 10.5696 7.58074 9.70869 8.55524C8.84783 9.52975 7.76377 10.1152 6.45652 10.3116V12.4646H8.36957V14.187H6.45652V16H4.54348ZM5.5 8.6119C6.50435 8.6119 7.35326 8.28329 8.04674 7.62606C8.74022 6.96884 9.08696 6.16431 9.08696 5.21246C9.08696 4.26062 8.74022 3.45609 8.04674 2.79887C7.35326 2.14164 6.50435 1.81303 5.5 1.81303C4.49565 1.81303 3.64674 2.14164 2.95326 2.79887C2.25978 3.45609 1.91304 4.26062 1.91304 5.21246C1.91304 6.16431 2.25978 6.96884 2.95326 7.62606C3.64674 8.28329 4.49565 8.6119 5.5 8.6119V8.6119Z"
                  fill="#F899D2"
                />
              </svg>
              <p className="mt-0.5 flex h-full flex-none items-center font-bold leading-none text-white/90">
                {100 - data.paternity}%
              </p>
            </div>
          </div>

          <p className="flex-none text-base font-bold text-white/65">
            Cor da pele
          </p>
          <div className="flex h-[2.5625rem] w-full flex-none justify-between items-center rounded gap-1">
            <button
              onClick={() => genetics.setColor((data.color - 1) >= 0 ? data.color - 1 : data.color)}
              className="bg-section grid size-[2.5625rem] flex-none place-items-center rounded-md border border-white/5 hover:bg-white/10 active:scale-95 transition-all duration-200"
            >
              <GeneralIcons.ChevronLeft className="h-3" />
            </button>
            <div className="bg-section grid h-full w-16 flex-none place-items-center rounded-md border border-white/5 text-center text-[1.1875rem] leading-none text-white/90">
              {data.color + 1}
            </div>
            <div className="bg-section flex size-full items-center rounded-md border border-white/5 px-3.5">
              <Slider
                className="relative flex h-[0.8125rem] w-full items-center overflow-visible transition-none duration-0"
                value={[data.color]}
                onValueChange={([v]) => genetics.setColor(v)}
                min={0}
                max={9}
                step={1}
              >
                <SliderTrack className="relative h-[0.3125rem] flex-grow rounded-full bg-white/15 transition-none duration-0" />
                <SliderThumb className="glow block size-[0.8125rem] rounded-full bg-primary transition-none duration-0" />
              </Slider>
            </div>
            <button
              onClick={() => genetics.setColor((data.color - 1) < 8 ? (data.color + 1) : data.color)}
              className="bg-section grid size-[2.5625rem] flex-none place-items-center rounded-md border border-white/15 hover:bg-white/10 active:scale-95 transition-all duration-200"
            >
              <GeneralIcons.ChevronRight className="h-3" />
            </button>
          </div>
        </ul>
        <Footer canClick={save.current} page="1" />
      </div>
      {showParentOptions && (
        <div className="scroll-hidden grid h-[39.9375rem] w-[21.3125rem] grid-cols-3 gap-[0.44rem] overflow-y-scroll rounded-xl bg-white/3 p-[0.56rem]">
          {parentOptions.map((parent, index) => {
            const active =
              showParentOptions === "Mothers"
                ? data.mother === index
                : data.father === index;
            return (
              <button
                onClick={() => {
                  if (showParentOptions === "Mothers") {
                    genetics.setMother(index);
                  } else {
                    genetics.setFather(index);
                  }
                }}
                key={index}
                className={cn(
                  "bg-section relative size-[6.4375rem] flex-none rounded-md border",
                  active ? "border-primary" : "border-white/5",
                )}
              >
                <img src={parent.image} draggable={false} />
                {active && (
                  <div className="absolute left-1/2 top-1/2 z-50 size-[1.8125rem] -translate-x-1/2 -translate-y-1/2">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="size-full"
                      viewBox="0 0 29 29"
                      fill="none"
                    >
                      <path
                        d="M14.5 0C18.3456 0 22.0338 1.52767 24.753 4.24695C27.4723 6.96623 29 10.6544 29 14.5C29 18.3456 27.4723 22.0338 24.753 24.753C22.0338 27.4723 18.3456 29 14.5 29C10.6544 29 6.96623 27.4723 4.24695 24.753C1.52767 22.0338 0 18.3456 0 14.5C0 10.6544 1.52767 6.96623 4.24695 4.24695C6.96623 1.52767 10.6544 0 14.5 0ZM12.6937 17.3606L9.47264 14.1375C9.35717 14.022 9.22008 13.9304 9.06921 13.8679C8.91833 13.8054 8.75663 13.7733 8.59332 13.7733C8.43002 13.7733 8.26831 13.8054 8.11744 13.8679C7.96656 13.9304 7.82947 14.022 7.714 14.1375C7.48079 14.3707 7.34977 14.687 7.34977 15.0168C7.34977 15.3466 7.48079 15.6629 7.714 15.8961L11.8154 19.9976C11.9306 20.1136 12.0676 20.2057 12.2185 20.2686C12.3694 20.3315 12.5313 20.3638 12.6947 20.3638C12.8582 20.3638 13.0201 20.3315 13.171 20.2686C13.3219 20.2057 13.4589 20.1136 13.5741 19.9976L22.0669 11.5026C22.1839 11.3876 22.277 11.2506 22.3408 11.0995C22.4046 10.9483 22.4379 10.786 22.4386 10.622C22.4394 10.4579 22.4077 10.2953 22.3453 10.1436C22.2829 9.99184 22.1911 9.85395 22.0751 9.73787C21.9592 9.62179 21.8214 9.52982 21.6698 9.46725C21.5181 9.40469 21.3555 9.37277 21.1915 9.37334C21.0274 9.37391 20.8651 9.40695 20.7139 9.47057C20.5626 9.53419 20.4255 9.62712 20.3104 9.744L12.6937 17.3606Z"
                        className="fill-primary"
                      />
                    </svg>
                  </div>
                )}
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
}
