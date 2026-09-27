import { useDescription, useSelectUsers } from "@/stores/useFine";
import { Icon } from "../../Navigation";
import { Post } from "@/hooks/post";
import { useNavigate } from "react-router-dom";

export function FineModal() {
  const navigate = useNavigate();
  const { current: selected } = useSelectUsers();
  const { current: value, set: setValue } = useDescription();
  const { set: setSelected } = useSelectUsers();

  const handleClose = () => {
    // Limpar seleção
    setSelected({
      suspects: [],
      infractions: []
    });
    // Limpar descrição
    setValue("");
    // Fechar modal
    navigate(-1);
  };

  return (
    <div className="absolute left-0 top-0 z-50 flex h-full w-full items-center justify-center">
      <div className="w-[27vw] rounded-[.5vw] border border-[#FFFFFF0D] bg-modal">
        <div className="flex h-[2.5vw] w-full items-center border-b border-solid border-[#FFFFFF08]">
          <Icon.modalAnnounce />
          <h1 className="text-[.8vw] font-[700] text-white">Multar Civil</h1>
        </div>
        <div className="flex w-full flex-col gap-[.5vw] p-[1vw]">
          <p className="text-[.8vw] text-[#FFFFFF73]">
            Você tem certeza que deseja realizar essa ação?
          </p>
          <div className="flex w-full items-center justify-between">
            <button
              onClick={() => {
                Post.create("confirmFine", {
                  users: selected,
                  description: value,
                }).then(() => {
                  handleClose();
                });
              }}
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
