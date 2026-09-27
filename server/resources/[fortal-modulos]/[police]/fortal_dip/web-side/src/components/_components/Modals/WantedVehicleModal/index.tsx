import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

export const WantedVehicleModal = () => {
  const navigate = useNavigate();
  const [specifications, setSpecifications] = useState("");
  const [model, setModel] = useState("");
  const [lastSeen, setLastSeen] = useState("");
  const [location, setLocation] = useState("");

  const handleClose = () => {
    // Limpar campos
    setModel("");
    setSpecifications("");
    setLastSeen("");
    setLocation("");
    // Fechar modal
    navigate(-1);
  };

  const handleConfirm = () => {
    if (!model || !specifications || !lastSeen || !location) {
      return;
    }

    Post.create("addWantedVehicle", {
      model: model,
      specifications: specifications,
      lastSeen: lastSeen,
      location: location,
    }).then(() => {
      handleClose();
    });
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Adicionar Veículo Procurado
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[.8vw]">
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">Modelo do Veículo</p>
            <input
              type="text"
              value={model}
              onChange={(e) => setModel(e.target.value)}
              placeholder="Escreva o modelo aqui..."
              className="h-[2.7vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section pl-[.8vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
            />
          </div>
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">Visto por Último</p>
            <input
              type="text"
              value={lastSeen}
              onChange={(e) => setLastSeen(e.target.value)}
              placeholder="Escreva aqui..."
              className="h-[2.7vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section pl-[.8vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
            />
          </div>
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">Última Localização</p>
            <input
              type="text"
              value={location}
              onChange={(e) => setLocation(e.target.value)}
              placeholder="Escreva a localização aqui..."
              className="h-[2.7vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section pl-[.8vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
            />
          </div>
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">
              Especificações do Veículo
            </p>
            <div className="relative">
              <h1 className="absolute bottom-0 right-0 z-50 p-[1vw] text-[.8vw] text-[#FFFFFF59]">
                <span
                  className={`${specifications.length >= 490 ? "text-red-500" : "text-[#FFFFFF80]"}`}
                >
                  {specifications.length}
                </span>{" "}
                / 500
              </h1>
              <textarea
                name=""
                onChange={(e) => setSpecifications(e.target.value)}
                value={specifications}
                maxLength={500}
                placeholder="Escreva as especificações aqui..."
                id=""
                className="h-[5vw] w-full resize-none rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section p-[.5vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
              ></textarea>
            </div>
            <div className="flex w-full items-center justify-between gap-[.5vw]">
              <button
                onClick={handleConfirm}
                className="h-[2.4vw] w-full rounded-[.4vw] border border-[#FFFFFF26] bg-buttonSelected text-[.8vw] font-[700] text-white shadow-[0_0_15px_#2A52F280] hover:scale-95"
              >
                Confirmar
              </button>
              <button
                onClick={handleClose}
                className="h-[2.4vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
              >
                Cancelar
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
