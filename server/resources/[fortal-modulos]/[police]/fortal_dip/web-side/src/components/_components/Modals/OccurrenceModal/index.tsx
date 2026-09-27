import { useDescription, useSelectOccurrence } from "@/stores/useOccurrence";

import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";

export function OccurrenceModal() {
  const navigate = useNavigate();
  const { current: selected } = useSelectOccurrence();
  const { current: value, set: setValue } = useDescription();
  const { set: setSelected } = useSelectOccurrence();

  const handleClose = () => {
    // Limpar dados
    setSelected({ applicant: [], suspects: [] });
    setValue("");
    // Fechar modal
    navigate(-1);
  };

  const handleConfirm = () => {
    if (!selected.applicant || selected.applicant.length === 0 || !value) {
      return;
    }

    // Preparar dados para o servidor
    const occurrenceData = {
      type: "Boletim de Ocorrência",
      description: value,
      applicant_id: selected.applicant[0]?.id,
      applicant_name: selected.applicant[0]?.name,
      suspect_id: selected.suspects[0]?.id,
      suspect_name: selected.suspects[0]?.name
    };

    Post.create("createOccurrence", occurrenceData).then(() => {
      handleClose();
    });
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="text-[.8vw] font-[700] text-white">
            Boletim de Ocorrência
          </h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <p className="text-[.8vw] text-[#FFFFFF73]">
            Você tem certeza que deseja criar este boletim de ocorrência?
          </p>
          <div className="flex w-full items-center justify-between">
            <button
              onClick={handleConfirm}
              className="h-[2.4vw] w-[12.2vw] rounded-[.4vw] border border-[#FFFFFF26] bg-buttonSelected text-[.8vw] font-[700] text-white shadow-[0_0_15px_#2A52F280] hover:scale-95"
            >
              Confirmar
            </button>
            <button
              onClick={handleClose}
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
