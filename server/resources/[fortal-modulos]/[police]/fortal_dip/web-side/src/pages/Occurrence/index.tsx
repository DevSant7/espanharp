import { occurrencesMockup, optionsMockupOccurrence } from "@/mockUp";
import {
  useDescription,
  useOccurrence,
  useOptions,
  useSelectOccurrence,
} from "@/stores/useOccurrence";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";

import { Icon } from "@/components/_components/Navigation";
import { Post } from "@/hooks/post";
import { Title } from "@/components/_components/Title";

export function Occurrence() {
  const [modal, setModal] = useState(false);
  const { current: occurrences, set: setOcurrences } = useOccurrence();
  const { current: selected, set: setSelected } = useSelectOccurrence();
  const [suspect, setSuspect] = useState(false);
  const [infraction, setInfraction] = useState(false);
  const { current: options, set: setOptions } = useOptions();
  const { current: value, set: setValue } = useDescription();
  const navigate = useNavigate();
  const location = useLocation();

  const openModal = (route: string) => {
    navigate(route, {
      state: { backgroundLocation: location },
    });
  };

  useEffect(() => {
    Post.create("getOccurrences", {}, occurrencesMockup).then((resp: any) => {
      setOcurrences(resp);
    });
    Post.create("getOptionsOccurrence", {}, optionsMockupOccurrence).then(
      (resp: any) => {
        setOptions(resp);
      },
    );

    // Listeners para atualização em tempo real
    const handleMessage = (event: MessageEvent) => {
      if (event.data.action === 'updateOccurrences') {
        setOcurrences(event.data.data);
      }
    };

    window.addEventListener('message', handleMessage);
    
    return () => {
      window.removeEventListener('message', handleMessage);
    };
  }, [setOcurrences]);

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
        <Icon.list className="text-primary drop-shadow-[0_0_15px_#2A52F2]" />
        <h1 className="pt-[.2vw] text-[.8vw] font-semibold text-white">
          Boletim de Ocorrência
        </h1>
      </Title>
      <div className="h-[calc(100%-2.5vw)] w-full p-[1vw]">
        {!modal ? (
          <div className="h-full w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
            <div className="flex h-[2.3vw] items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF05] px-[1vw]">
              <h1 className="text-[.8vw] text-white">
                Lista de Boletins de Ocorrência
              </h1>
              <button onClick={() => setModal(!modal)}>
                <Icon.add className="size-[.8vw] text-[#59585F] hover:text-white" />
              </button>
            </div>
            <div className="flex h-[calc(100%-2.3vw)] w-full flex-col overflow-auto">
              <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF08] px-[.5vw]">
                <h1 className="w-[5vw] text-[.8vw] text-[#FFFFFFA6]">ID</h1>
                <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">Data</h1>
                <h1 className="w-[10vw] text-[.8vw] text-[#FFFFFFA6]">
                  Agente
                </h1>
                <h1 className="w-[10vw] text-[.8vw] text-[#FFFFFFA6]">
                  Descrição
                </h1>
                <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">Status</h1>
                <h1 className="text-end text-[.8vw] text-[#FFFFFFA6]">Ações</h1>
              </div>
              {occurrences.map((data) => (
                <div className="flex h-[2vw] w-full flex-none items-center justify-between border-b border-solid border-[#FFFFFF14] bg-[#FFFFFF08] px-[.5vw]">
                  <h1 className="w-[5vw] text-[.8vw] text-[#FFFFFFA6]">
                    #{data.id}
                  </h1>
                  <h1 className="w-[8vw] text-[.8vw] text-[#FFFFFFA6]">
                    {data.date}
                  </h1>
                  <div className="flex w-[10vw] items-center gap-[.3vw]">
                    <div className="rounded-[.2vw] border border-[#FFFFFF12] bg-[#FFFFFF0D] px-[.3vw] py-[.1vw]">
                      <h1 className="text-[.7vw] text-white">
                        #{data.officerName ? data.officerName.split(' ')[0] : 'N/A'}
                      </h1>
                    </div>
                    <h1 className="text-[.8vw] text-[#FFFFFFA6]">
                      {data.officerName || 'N/A'}
                    </h1>
                  </div>
                  <h1 className="w-[10vw] text-[.8vw] text-[#FFFFFFA6]">
                    {data.description.length > 20
                      ? `${data.description.slice(0, 20)}...`
                      : data.description}
                  </h1>
                  <h1 className="flex w-[8vw] items-center gap-[.5vw] text-[.8vw] text-[#FFFFFFA6]">
                    <div
                      className={`h-[.3vw] w-[.3vw] rounded-full ${data.status === "Aberto" ? "bg-[#7AFF73] shadow-[0_0_15px_#7AFF7380]" : "bg-[#FF7373] shadow-[0_0_15px_#FF737380]"}`}
                    />
                    {data.status || "N/A"}
                  </h1>
                  <button
                    onClick={() =>
                      Post.create("deleteOccurrence", { id: data.id })
                    }
                  >
                    <h1 className="text-end text-[.8vw] text-[#DE5757C9] hover:text-[#DE5757C9]/50">
                      Excluir
                    </h1>
                  </button>
                </div>
              ))}
            </div>
          </div>
        ) : (
          <div className="flex h-full w-full flex-col overflow-auto">
            <h1 className="text-[.8vw] text-[#FFFFFF4D]">
              Você está realizando um boletim de ocorrência
            </h1>
            <button
              onClick={() => setModal(!modal)}
              className="mt-[.5vw] flex h-[2.5vw] w-full flex-none items-center gap-[.5vw] rounded-[.4vw] border border-[#FFFFFF0D] bg-buttonSelected px-[1vw] text-[.8vw] text-white"
            >
              <svg
                width=".9vw"
                height=".9vw"
                viewBox="0 0 18 18"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M1.92857 15.4286C1.92857 15.7821 2.21786 16.0714 2.57143 16.0714H15.4286C15.7821 16.0714 16.0714 15.7821 16.0714 15.4286V2.57143C16.0714 2.21786 15.7821 1.92857 15.4286 1.92857H2.57143C2.21786 1.92857 1.92857 2.21786 1.92857 2.57143V15.4286ZM2.57143 18C1.15313 18 0 16.8469 0 15.4286V2.57143C0 1.15313 1.15313 0 2.57143 0H15.4286C16.8469 0 18 1.15313 18 2.57143V15.4286C18 16.8469 16.8469 18 15.4286 18H2.57143ZM5.14286 9C5.14286 8.7308 5.25536 8.47768 5.45223 8.29286L9.95223 4.11429C10.2335 3.85312 10.6433 3.78482 10.9929 3.9375C11.3424 4.09018 11.5714 4.43973 11.5714 4.82143V13.1786C11.5714 13.5603 11.3424 13.9098 10.9929 14.0625C10.6433 14.2152 10.2335 14.1469 9.95223 13.8857L5.45223 9.70714C5.25536 9.52634 5.14286 9.2692 5.14286 9Z"
                  fill="white"
                />
                <path
                  d="M1.92857 15.4286C1.92857 15.7821 2.21786 16.0714 2.57143 16.0714H15.4286C15.7821 16.0714 16.0714 15.7821 16.0714 15.4286V2.57143C16.0714 2.21786 15.7821 1.92857 15.4286 1.92857H2.57143C2.21786 1.92857 1.92857 2.21786 1.92857 2.57143V15.4286ZM2.57143 18C1.15313 18 0 16.8469 0 15.4286V2.57143C0 1.15313 1.15313 0 2.57143 0H15.4286C16.8469 0 18 1.15313 18 2.57143V15.4286C18 16.8469 16.8469 18 15.4286 18H2.57143ZM5.14286 9C5.14286 8.7308 5.25536 8.47768 5.45223 8.29286L9.95223 4.11429C10.2335 3.85312 10.6433 3.78482 10.9929 3.9375C11.3424 4.09018 11.5714 4.43973 11.5714 4.82143V13.1786C11.5714 13.5603 11.3424 13.9098 10.9929 14.0625C10.6433 14.2152 10.2335 14.1469 9.95223 13.8857L5.45223 9.70714C5.25536 9.52634 5.14286 9.2692 5.14286 9Z"
                  fill="url(#paint0_radial_857_3)"
                  fill-opacity="0.25"
                />
                <path
                  d="M2.57129 0.5H15.4287C16.5708 0.500076 17.4999 1.42924 17.5 2.57129V15.4287C17.4999 16.5708 16.5708 17.4999 15.4287 17.5H2.57129C1.42924 17.4999 0.500076 16.5708 0.5 15.4287V2.57129C0.500076 1.42924 1.15313 0.500076 2.57129 0.5ZM2.57129 1.42871C1.94169 1.42879 1.42879 1.94169 1.42871 2.57129V15.4287C1.42879 16.0583 1.94169 16.5712 2.57129 16.5713H15.4287C16.0583 16.5712 16.5712 16.0583 16.5713 15.4287V2.57129C16.5712 1.94169 16.0583 1.42879 15.4287 1.42871H2.57129ZM10.292 4.48047C10.4269 4.35518 10.6251 4.32219 10.793 4.39551C10.9604 4.46871 11.0712 4.63861 11.0713 4.82129V13.1787C11.0712 13.3614 10.9604 13.5313 10.793 13.6045C10.6251 13.6778 10.4269 13.6448 10.292 13.5195L5.79199 9.34082L5.79004 9.33887C5.69724 9.25353 5.64258 9.13023 5.64258 9C5.64258 8.87283 5.69581 8.75027 5.79492 8.65723L5.79395 8.65625L10.292 4.48047Z"
                  stroke="white"
                  stroke-opacity="0.05"
                />
                <defs>
                  <radialGradient
                    id="paint0_radial_857_3"
                    cx="0"
                    cy="0"
                    r="1"
                    gradientUnits="userSpaceOnUse"
                    gradientTransform="translate(8.97179 13.8) scale(10.8056 17.1847)"
                  >
                    <stop stop-color="white" />
                    <stop offset="1" stop-color="white" stop-opacity="0" />
                  </radialGradient>
                </defs>
              </svg>
              Voltar
            </button>
            <div className="mt-[.5vw] flex w-full flex-col gap-[.5vw] overflow-auto">
              <div className="w-full flex-none rounded-[.3vw] border border-[#FFFFFF08] bg-section">
                <div className="flex h-[2.3vw] items-center justify-between bg-[#FFFFFF05] px-[1vw]">
                  <h1 className="text-[.8vw] text-white">
                    Adicionar Requerente
                  </h1>
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
                          Anexar{" "}
                          <span className="text-[#FFFFFFD9]">Requerente</span>
                        </h1>
                      </div>
                      <Icon.arrowBotom />
                    </div>

                    {suspect && (
                      <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                        {options?.applicant?.map((data) => {
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
                  <h1 className="text-[.8vw] text-white">
                    Adicionar Suspeitos
                  </h1>
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
                          Anexar{" "}
                          <span className="text-[#FFFFFFD9]">Suspeitos</span>
                        </h1>
                      </div>
                      <Icon.arrowBotom />
                    </div>
                    {infraction && (
                      <div className="flex w-full flex-wrap items-start gap-[.5vw]">
                        {options?.suspects?.map((data, index) => {
                          const item = { ...data, id: index };
                          const isSelected = selected.suspects.some(
                            (i) => i.id === index,
                          );

                          return (
                            <div
                              key={index}
                              onClick={() => toggleSelection("suspects", item)}
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
                                  {data.id}
                                </h1>
                              </div>
                              <h1
                                className={`z-10 text-[.8vw] ${
                                  isSelected ? "text-white/40" : "text-white"
                                }`}
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
                  <h1 className="text-[.8vw] text-white">
                    Descrição do Boletim
                  </h1>
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
                        placeholder="Descreva o boletim de ocorrência aqui..."
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
                    setSelected({ applicant: [], suspects: [] });
                    setValue("");
                  }}
                  className="h-[2.5vw] w-full rounded-[.5vw] border border-[#FFFFFF08] bg-section text-[#FFFFFFD9] hover:text-white"
                >
                  Resetar Dados
                </button>
                <button
                  onClick={() => openModal("/panel/occurrence/modal")}
                  className="h-[2.5vw] w-[8vw] rounded-[.4vw] bg-buttonSelected text-[.8vw] text-white"
                >
                  Criar Boletim
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
