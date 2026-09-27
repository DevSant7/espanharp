import { useDescription, useOptions, useSelectUsers } from "@/stores/useFine";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";
import { optionsMockupFine } from "@/mockUp";

export function Fine() {
  const [suspect, setSuspect] = useState(false);
  const [infraction, setInfraction] = useState(false);
  const { current: options, set: setOptions } = useOptions();
  const { current: selected, set: setSelected } = useSelectUsers();
  const { current: value, set: setValue } = useDescription();
  const navigate = useNavigate();
  const location = useLocation();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: location },
    });
  };

  useEffect(() => {
    Post.create("getOptionsFine", {}, optionsMockupFine).then((resp: any) => {
      setOptions(resp);
    });
  }, []);

  function toggleSelection(type: keyof typeof selected, item: { id: number }) {
    const list = selected[type];
    const alreadySelected = list.some((i) => i.id === item.id);

    const updateList = alreadySelected
      ? list.filter((i) => i.id !== item.id)
      : [...list, item];

    setSelected({
      ...selected,
      [type]: updateList,
    });
  }

  return (
    <div className="h-full w-[calc(100%-5vw)]">
      <Title>
        <Icon.warn className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Multar Civil
        </h1>
      </Title>

      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        <h1 className="text-[.8vw] text-[#FFFFFF4D]">
          Você está aplicando uma multa. Selecione os suspeitos e infrações cometidas.
        </h1>

        <div className="mt-[.5vw] flex h-[28.5vw] w-full flex-col gap-[.5vw] overflow-auto">
          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Adicionar Suspeitos</h1>
            </div>

            <div className="flex w-full p-[.5vw]">
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                <div
                  onClick={() => setSuspect(!suspect)}
                  className="flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw]"
                >
                  <div className="flex items-center gap-[.5vw]">
                    <Icon.anex />
                    <h1 className="text-[.8vw] text-[#FFFFFF80]">
                      Anexar <span className="text-[#FFFFFFD9]">Suspeitos</span>
                    </h1>
                  </div>
                  <Icon.arrowBotom />
                </div>

                {suspect && (
                  <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                    {options.suspect.map((data) => {
                      const isSelected = selected.suspects.some(
                        (s) => s.id === data.id,
                      );
                      return (
                        <div
                          key={data.id}
                          onClick={() => toggleSelection("suspects", data)}
                          className={`relative flex h-[2vw] w-fit cursor-pointer items-center gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw] ${
                            isSelected
                              ? "bg-[#F5534F]"
                              : "bg-section hover:bg-white/5"
                          }`}
                        >
                          {isSelected && (
                            <div className="absolute left-0 z-50 flex h-full w-full items-center justify-center rounded-[.2vw] bg-[#FF5858D9] text-[1vw] text-white">
                              ✕
                            </div>
                          )}
                          <div className="z-10 rounded-[.1vw] bg-primary px-[.3vw] py-[.2vw]">
                            <h1 className="text-[.8vw] leading-none text-white">
                              #{data.id}
                            </h1>
                          </div>
                          <h1
                            className={`z-10 text-[.8vw] ${isSelected ? "text-white/40" : "text-white"}`}
                          >
                            {data.name}
                          </h1>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Infrações Cometidas</h1>
            </div>

            <div className="flex w-full p-[.5vw]">
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                <div
                  onClick={() => setInfraction(!infraction)}
                  className="flex h-[2.3vw] cursor-pointer items-center justify-between rounded-[.3vw] border border-[#FFFFFF08] bg-section px-[.8vw]"
                >
                  <div className="flex items-center gap-[.5vw]">
                    <Icon.anex />
                    <h1 className="text-[.8vw] text-[#FFFFFF80]">
                      Anexar <span className="text-[#FFFFFFD9]">Infrações</span>
                    </h1>
                  </div>
                  <Icon.arrowBotom />
                </div>
                {infraction && (
                  <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                    {options.infractions.map((data, index) => {
                      const item = { ...data, id: index };
                      const isSelected = selected.infractions.some(
                        (i) => i.id === index,
                      );

                      return (
                        <div
                          key={index}
                          onClick={() => toggleSelection("infractions", item)}
                          className={`relative flex h-[2vw] w-fit cursor-pointer items-center gap-[.5vw] rounded-[.2vw] border border-[#FFFFFF08] px-[.5vw] ${
                            isSelected
                              ? "bg-[#F5534F]"
                              : "bg-section hover:bg-white/5"
                          }`}
                        >
                          {isSelected && (
                            <div className="absolute left-0 z-50 flex h-full w-full items-center justify-center rounded-[.2vw] bg-[#FF5858D9] text-[1vw] text-white">
                              ✕
                            </div>
                          )}
                          <div className="z-10 rounded-[.1vw] bg-primary px-[.3vw] py-[.2vw]">
                            <h1 className="text-[.8vw] leading-none text-white">
                              Art. {data.art}
                            </h1>
                          </div>
                          <h1
                            className={`z-10 text-[.8vw] ${
                              isSelected ? "text-white/40" : "text-white"
                            }`}
                          >
                            {data.description}
                          </h1>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">Descrição da Multa</h1>
            </div>
            <div className="flex w-full p-[.5vw]">
              <div className="announce-scroll flex h-full w-full flex-col gap-[.5vw] overflow-auto">
                <div className="relative">
                  <h1 className="absolute bottom-0 right-0 z-50 p-[1vw] text-[.8vw] text-[#FFFFFF59]">
                    <span
                      className={`${value.length >= 490 ? "text-red-500" : "text-[#FFFFFF80]"}`}
                    >
                      {value.length}
                    </span>{" "}
                    / 500
                  </h1>
                  <textarea
                    name=""
                    onChange={(e) => setValue(e.target.value)}
                    value={value}
                    maxLength={500}
                    placeholder="Descreva o motivo da multa aqui..."
                    className="h-[10vw] w-full resize-none rounded-[.3vw] border border-[#FFFFFF08] bg-transparent bg-section p-[.5vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80]"
                    id=""
                  ></textarea>
                </div>
              </div>
            </div>
          </div>
          <div className="flex w-full items-center gap-[.5vw]">
            <button
              onClick={() => {
                setSelected({ suspects: [], infractions: [] });
                setValue("");
              }}
              className="h-[2.5vw] w-full rounded-[.5vw] border border-[#FFFFFF08] bg-section text-[#FFFFFFD9] hover:text-white"
            >
              Resetar Dados
            </button>
            <button
              onClick={() => openModal("/panel/fine/modal")}
              className="h-[2.5vw] w-[8vw] rounded-[.4vw] bg-buttonSelected text-[.8vw] text-white"
            >
              Multar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
