import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

export function AddMember() {
  const navigate = useNavigate();
  const [value, setValue] = useState("");

  const handleClose = () => {
    // Limpar campo
    setValue("");
    // Fechar modal
    navigate(-1);
  };

  const handleConfirm = () => {
    if (!value) {
      return;
    }

    Post.create("hireMember", { id: value }).then(() => {
      if (window.invokeNative) {
        fetch('https://fortal_dip/closeNUI', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({}),
        });
      }
    }).catch((error) => {
      console.error('[MODAL] Erro ao contratar membro:', error);
    });
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Convidar Membro para sua Corporação
          </h1>
        </div>
        <div className="w-full p-[1vw]">
          <h1 className="text-[.8vw] text-[#FFFFFF80]">ID do Convidado</h1>
          <input
            type="number"
            value={value}
            onChange={(e) => setValue(e.target.value)}
            className="mt-[.5vw] h-[2.5vw] w-full rounded-[.4vw] border border-[#DEE5FF59] bg-transparent bg-section px-[1vw] text-[.8vw] text-white placeholder:text-[#DEE5FF]"
            placeholder="Escreva o ID aqui..."
          />
          <div className="mt-[.5vw] flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={handleConfirm}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF26] bg-buttonSelected text-[.8vw] text-white shadow-[0_0_15px_#2A52F280]"
            >
              Confirmar
            </button>
            <button
              onClick={handleClose}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

// Modal de confirmação para demitir membro
export function FireMemberModal({ memberData }: { memberData: any }) {
  const navigate = useNavigate();

  const handleClose = () => {
    navigate(-1);
  };

  const handleConfirm = () => {
  
    Post.create("removePlayer", { id: memberData.id }).then(() => {
      handleClose();
    }).catch((error) => {
      console.error('[FIRE MODAL] Erro ao demitir membro:', error);
    });
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="pt-[.2vw] text-[.8vw] font-[700] text-white">
            Demitir Membro
          </h1>
        </div>
        <div className="w-full p-[1vw]">
          <p className="text-[.8vw] text-[#FFFFFF73]">
            Deseja demitir <strong>{memberData?.name}</strong> (ID: {memberData?.id}) da corporação?
          </p>
          <p className="mt-[.5vw] text-[.7vw] text-[#FF6868]">
            Esta ação não pode ser desfeita.
          </p>
          <div className="mt-[.5vw] flex w-full items-center justify-between gap-[.5vw]">
            <button
              onClick={handleConfirm}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FF686826] bg-[#FF6868] text-[.8vw] text-white shadow-[0_0_15px_#FF686880]"
            >
              Confirmar Demissão
            </button>
            <button
              onClick={handleClose}
              className="font-700 h-[2.5vw] w-full rounded-[.4vw] border border-[#FFFFFF08] bg-section text-[.8vw] text-[#FFFFFF80]"
            >
              Cancelar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
