import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

export function AnnounceModal() {
  const navigate = useNavigate();
  const [message, setMessage] = useState("");
  const [title, setTitle] = useState("");

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Criar Aviso
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">Título do aviso</p>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Escreva o título aqui..."
              className="h-[2.7vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section pl-[.8vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
            />
          </div>
          <div className="flex flex-col gap-[.5vw]">
            <p className="text-[.7vw] text-[#FFFFFF80]">Mensagem do aviso</p>
            <div className="relative">
              <h1 className="absolute bottom-0 right-0 z-50 p-[1vw] text-[.8vw] text-[#FFFFFF59]">
                <span
                  className={`${message.length >= 490 ? "text-red-500" : "text-[#FFFFFF80]"}`}
                >
                  {message.length}
                </span>{" "}
                / 500
              </h1>
              <textarea
                value={message}
                onChange={(e) => setMessage(e.target.value)}
                maxLength={500}
                className="h-[10vw] w-full resize-none rounded-[.4vw] border border-[#FFFFFF08] bg-transparent bg-section p-[.5vw] text-[.8vw] text-white placeholder:text-[#FFFFFF80] focus:border-[#DEE5FF59] focus:placeholder:text-[#DEE5FF]"
                placeholder="Escreva a mensagem aqui..."
              ></textarea>
            </div>
          </div>
          <div className="flex w-full items-center justify-between">
            <button
              onClick={() => {
                Post.create("createAnnounce", {
                  title: title,
                  message: message,
                });
                setTitle("");
                setMessage("");
                navigate(-1); 
              }}
              className="h-[2.4vw] w-[12.2vw] rounded-[.4vw] border border-[#FFFFFF26] bg-buttonSelected text-[.8vw] font-[700] text-white shadow-[0_0_15px_#2A52F280] hover:scale-95"
            >
              Confirmar
            </button>
            <button
              onClick={() => navigate(-1)}
              className="h-[2.4vw] w-[12.2vw] rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
