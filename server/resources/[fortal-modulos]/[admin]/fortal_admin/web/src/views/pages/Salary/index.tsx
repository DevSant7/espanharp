import * as motion from "motion/react-client";
import { debugData } from "@app/utils/debugData";
import { Separator } from "@views/components/ui/separator";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@views/components/ui/table";
import { useNuiEvent } from "@app/hooks/useNuiEvent";
import { useState, useEffect } from "react";
import { Search } from "lucide-react";
import { Modal } from "@views/components/modal";
import { fetchNui } from "@app/utils/fetchNui";

debugData([
  {
    action: "setSalary",
    data: {
      salarys: [
        {
          id: 1,
          name: "Lucas Brida",
          salary: 21,
          members: 21,
          maxMembers: 50,
        },
        {
          id: 2,
          name: "Pedro",
          salary: 19,
          members: 18,
          maxMembers: 50,
        },
        {
          id: 3,
          name: "João",
          salary: 22,
          members: 22,
          maxMembers: 50,
        },
        {
          id: 4,
          name: "Maria",
          salary: 18,
          members: 18,
          maxMembers: 50,
        },
        {
          id: 5,
          name: "Ana",
          salary: 20,
          members: 20,
          maxMembers: 50,
        },
        {
          id: 6,
          name: "Carlos",
          salary: 23,
          members: 23,
          maxMembers: 50,
        },
        {
          id: 7,
          name: "Beatriz",
          salary: 24,
          members: 24,
          maxMembers: 50,
        },
        {
          id: 8,
          name: "Rafael",
          salary: 25,
          members: 25,
          maxMembers: 50,
        },
        {
          id: 9,
          name: "Fernanda",
          salary: 26,
          members: 26,
          maxMembers: 50,
        },
        {
          id: 10,
          name: "Marcos",
          salary: 27,
          members: 27,
          maxMembers: 50,
        },
        {
          id: 11,
          name: "Julia",
          salary: 28000,
          members: 28,
          maxMembers: 50,
        },
      ],
    },
  },
]);

interface SalaryProps {
  id: number;
  name: string;
  salary: number;
  members: number;
  maxMembers: number;
}

export function Salary() {
  const [salarys, setSalary] = useState<SalaryProps[] | null>(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [modalDefineSalaryOpen, setModalDefineSalaryOpen] = useState(false);
  const [modalCreateSalaryGroupOpen, setModalCreateSalaryGroupOpen] = useState(false);
  const [salaryAmount, setSalaryAmount] = useState<string>("20000");
  const [orgName, setOrgName] = useState<string>("");
  const [orgSalary, setOrgSalary] = useState<string>("");
  const [orgPermission, setOrgPermission] = useState<string>("");

  const filteredSalarys = salarys?.filter((salary) =>
    salary.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  useNuiEvent("setSalary", (data) => {
    setSalary(data.salarys);
  });

  useNuiEvent("receiveSalaries", (data) => {
    setSalary(data);
  });

  useEffect(() => {
    fetchNui("getSalaries");
  }, []);


  return (
    <>
      <motion.div
        initial={{ opacity: 0, scale: 0 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{
          duration: 0.4,
          scale: { type: "spring", visualDuration: 0.4, bounce: 0.2 },
        }}
        className="w-[72rem] flex flex-col"
      >
        <h1 className="text-white text-xl font-bold mt-[1.31rem] ml-[1.56rem]">
          Salários
        </h1>
        <Separator className="w-full h-[0.0625rem] bg-[#FFFFFF03] mt-[1.2rem]" />

        <div className="flex items-center gap-4 w-[70rem] ml-[1.06rem] mt-4">
          <div className="relative flex-1">
            <input
              type="text"
              placeholder="Buscar"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full h-[3.125rem] text-white/85 placeholder-white/50 border border-white/[.03] rounded-md px-4 pl-10 py-2 outline-none text-base"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            />
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-[#FFFFFF59] w-5 h-5" />
          </div>
          <button
            onClick={() => setModalCreateSalaryGroupOpen(true)}
            className="h-[3.125rem] px-6 bg-[#df5454] text-white font-bold rounded-md hover:bg-[#3577C7] transition-colors whitespace-nowrap"
          >
            + Adicionar Grupo
          </button>
        </div>

        <div className="overflow-y-auto h-[40rem] scrollbar-hide">
          <Table className="leading-[2.75rem] bg-[#FFFFFF03] w-[69.9375rem] m-4 border border-white/[.03] rounded-[0.375rem]">
            <TableHeader className="bg-[#FFFFFF05] text-white/60 text-[0.9375rem] font-bold">
              <TableRow>
                <TableHead>NOME</TableHead>
                <TableHead>SALÁRIO</TableHead>
                <TableHead>SETADOS</TableHead>
                <TableHead className="text-right">AÇÕES</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {filteredSalarys?.map((salary) => (
                <TableRow key={salary.id}>
                  <TableCell className="text-white text-[1.125rem] font-medium max-w-[12.5rem] truncate">
                    {salary.name}
                  </TableCell>

                  <TableCell className="text-white/65 text-[1.125rem] font-medium">
                    $ {salary.salary.toLocaleString()}
                  </TableCell>

                  <TableCell className="text-white text-[1.125rem] font-medium">
                    {(() => {
                      console.log("DEBUG salary.members:", salary.members, typeof salary.members);
                      const members = salary.members as any;
                      
                      let count = 0;
                      
                      // Se for um objeto, tenta extrair o valor numérico
                      if (typeof members === 'object' && members !== null) {
                        // Se for um array, pega o comprimento
                        if (Array.isArray(members)) {
                          count = members.length > 0 ? members.length : 0;
                        } else {
                          // Se for um objeto, tenta pegar uma propriedade numérica
                          const numericValue = Object.values(members).find((val: any) => typeof val === 'number') as number | undefined;
                          count = numericValue !== undefined ? numericValue : 0;
                        }
                      } else if (members === null || members === undefined || members === 0) {
                        count = 0;
                      } else if (typeof members === 'number') {
                        count = members;
                      } else {
                        count = 0;
                      }
                      
                      return (
                        <span>
                          {count}
                          <span className="text-white/35 text-[1.125rem] font-medium">/100</span>
                        </span>
                      );
                    })()}
                  </TableCell>
                  <TableCell className="text-right">
                    <div className="flex items-center justify-end w-full h-full">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="1.3125rem"
                        height="1.3125rem"
                        viewBox="0 0 21 21"
                        fill="none"
                        className="cursor-pointer hover:opacity-80 transition-opacity"
                        onClick={() => setModalDefineSalaryOpen(true)}
                      >
                      <path
                        d="M19.5443 0.680695C18.6367 -0.226898 17.1697 -0.226898 16.2621 0.680695L15.0147 1.92397L19.0719 5.9812L20.3193 4.73378C21.2269 3.82619 21.2269 2.35912 20.3193 1.45153L19.5443 0.680695ZM7.1447 9.79807C6.8919 10.0509 6.69712 10.3617 6.58523 10.7057L5.35853 14.3858C5.23834 14.7422 5.33366 15.1359 5.5989 15.4052C5.86413 15.6746 6.25783 15.7658 6.61838 15.6456L10.2985 14.4189C10.6383 14.307 10.9491 14.1122 11.2061 13.8594L18.1394 6.92195L14.0781 2.86058L7.1447 9.79807ZM3.97849 2.43372C1.78203 2.43372 0 4.21575 0 6.41221V17.0215C0 19.218 1.78203 21 3.97849 21H14.5878C16.7843 21 18.5663 19.218 18.5663 17.0215V13.043C18.5663 12.3095 17.9737 11.7169 17.2401 11.7169C16.5066 11.7169 15.914 12.3095 15.914 13.043V17.0215C15.914 17.755 15.3213 18.3477 14.5878 18.3477H3.97849C3.24496 18.3477 2.65233 17.755 2.65233 17.0215V6.41221C2.65233 5.67867 3.24496 5.08604 3.97849 5.08604H7.95698C8.69051 5.08604 9.28314 4.49341 9.28314 3.75988C9.28314 3.02635 8.69051 2.43372 7.95698 2.43372H3.97849Z"
                        fill="white"
                        fill-opacity="0.45"
                      />
                    </svg>
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </motion.div>

      <Modal
        open={modalDefineSalaryOpen}
        onClose={() => setModalDefineSalaryOpen(false)}
      >
        <div className="w-full p-6">
          {/* Header com ícone e título */}
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="#df5454">
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">
              Definir novo salário
            </h2>
          </div>

          {/* Campo Definir Salário */}
          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Definir Salário
            </label>
            <div className="relative">
              <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-white/40 text-sm">
                $
              </span>
              <input
                type="text"
                value={salaryAmount}
                onChange={(e) => setSalaryAmount(e.target.value)}
                className="w-full h-12 pl-8 pr-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
              />
            </div>
          </div>

          {/* Botões */}
          <div className="flex items-center gap-3">
            <button
              onClick={() => setModalDefineSalaryOpen(false)}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={() => {
                // Lógica para definir o novo salário
                console.log("Novo salário:", salaryAmount);
                setModalDefineSalaryOpen(false);
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              DEFINIR
            </button>
          </div>
        </div>
      </Modal>

      {/* Modal para criar novo grupo de salário */}
      <Modal
        open={modalCreateSalaryGroupOpen}
        onClose={() => setModalCreateSalaryGroupOpen(false)}
      >
        <div className="w-full p-6">
          {/* Header com ícone e título */}
          <div className="flex items-center gap-3 mb-6">
            <div className="w-6 h-6 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="#df5454">
                <path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z" />
              </svg>
            </div>
            <h2 className="text-white text-lg font-bold">
              Criar nova Organização
            </h2>
          </div>

          {/* Campo Nome da Organização */}
          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Nome da Organização
            </label>
            <input
              type="text"
              placeholder="EX: Hospital Santa Helena"
              value={orgName}
              onChange={(e) => setOrgName(e.target.value)}
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          {/* Campo Salário */}
          <div className="mb-4">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Definir Salário
            </label>
            <div className="relative">
              <span className="absolute left-4 top-1/2 transform -translate-y-1/2 text-white/40 text-sm">
                $
              </span>
              <input
                type="text"
                placeholder="20000"
                value={orgSalary}
                onChange={(e) => setOrgSalary(e.target.value)}
                className="w-full h-12 pl-8 pr-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
              />
            </div>
          </div>

          {/* Campo Permissão */}
          <div className="mb-8">
            <label className="block text-white/60 text-sm font-medium mb-2">
              Permissão
            </label>
            <input
              type="text"
              placeholder="EX: Police"
              value={orgPermission}
              onChange={(e) => setOrgPermission(e.target.value)}
              className="w-full h-12 px-4 rounded-md bg-white/5 border border-white/10 text-white placeholder-white/40 text-sm outline-none focus:border-[#df5454] transition-colors"
            />
          </div>

          {/* Botões */}
          <div className="flex items-center gap-3">
            <button
              onClick={() => {
                setModalCreateSalaryGroupOpen(false);
                setOrgName("");
                setOrgSalary("");
                setOrgPermission("");
              }}
              className="flex-1 h-12 rounded-md bg-white/5 border border-white/10 text-white/60 font-medium hover:bg-white/10 transition-colors"
            >
              CANCELAR
            </button>
            <button
              onClick={async () => {
                if (orgName && orgSalary && orgPermission) {
                  console.log("Enviando dados:", { name: orgName, group: orgPermission, amount: parseInt(orgSalary) });
                  try {
                    console.log("Chamando fetchNui...");
                    const result = await fetchNui("addNewSalary", {
                      name: orgName,
                      group: orgPermission,
                      amount: parseInt(orgSalary)
                    });
                    console.log("Callback executado com sucesso:", result);
                    setModalCreateSalaryGroupOpen(false);
                    setOrgName("");
                    setOrgSalary("");
                    setOrgPermission("");
                  } catch (error) {
                    console.error("Erro no callback:", error);
                  }
                } else {
                  console.log("Campos não preenchidos:", { orgName, orgSalary, orgPermission });
                }
              }}
              className="flex-1 h-12 rounded-md bg-[#df5454] text-white font-bold hover:bg-[#3577C7] transition-colors"
            >
              DEFINIR
            </button>
          </div>
        </div>
      </Modal>
    </>
  );
}
