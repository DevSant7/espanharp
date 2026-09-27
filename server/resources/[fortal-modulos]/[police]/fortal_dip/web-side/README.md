# Fortal Police NUI Boilerplate

Este projeto é um boilerplate para interfaces NUI de FiveM usando React, TypeScript e TailwindCSS.

## Como funciona

A comunicação entre o frontend (NUI) e o backend (FiveM) é feita por três funções utilitárias principais:

- `Post.create` — Envia requisições do NUI para o backend.
- `observe` — Observa eventos enviados do backend para o NUI.
- `listen` — Observa eventos do DOM (ex: teclado) no NUI.

---

## 1. Post.create

Envia uma requisição para o backend do FiveM e recebe a resposta.

```ts
import { Post } from "@/hooks/post";

// Exemplo: Buscar avisos
Post.create("getWarns").then((resp) => {
  // resp = resposta do backend
});

// Exemplo: Enviar dados
Post.create("addMember", { id: 123 });
```

- O primeiro parâmetro é o nome do evento registrado no backend.
- O segundo parâmetro (opcional) são os dados enviados.
- O terceiro parâmetro (opcional) é um mock para testes no browser.

### Exemplos reais de uso de Post.create

```ts
// Buscar avisos
yarnPost.create("getWarns", {}, warnsMockup).then((resp) => {
  setAnnounce(resp);
});

// Buscar estatísticas
Post.create(
  "bsPolice:backend",
  { action: "statistics" },
  statisticsMockupDate,
).then((statistics) => {
  // uso dos dados
});

// Buscar membros
Post.create("getMembers", {}, membersMockup).then((resp) => {
  setMembers(resp);
});

// Buscar procurados
Post.create("getWantedUsers", {}, wantedUserMockup).then((resp) => {
  setUsers(resp);
});
Post.create("getWantedVehicles", {}, wantedVehicleMockup).then((resp) => {
  setVehicles(resp);
});

// Buscar ocorrências e opções
Post.create("getOccurrences", {}, occurrencesMockup).then((resp) => {
  setOcurrences(resp);
});
Post.create("getOptionsOccurrence", {}, optionsMockupOccurrence).then(
  (resp) => {
    setOptions(resp);
  },
);

// Buscar opções de multa e prisão
Post.create("getOptionsFine", {}, optionsMockupFine).then((resp) => {
  setOptions(resp);
});
Post.create("getOptions", {}, optionsMockup).then((resp) => {
  setOptions(resp);
});

// Buscar jogadores
Post.create("getPlayers").then((resp) => {
  setPlayers(resp);
});

// Adicionar membro
Post.create("addMember", { id: value });

// Sair da organização
Post.create("leaveOrg");

// Confirmar ações em modais
Post.create("confirmPrison", {
  users: selected,
  description: value,
});
Post.create("confirmOccurrence", {
  occurrence: selected,
  description: value,
});
Post.create("confirmWantedUser", {
  name: name,
  description: description,
  lastSeen: lastSeen,
  location: location,
});

// Remover histórico de jogador
Post.create("removeHistory", {
  time: data.time,
  id: data.id,
});

// Excluir ocorrência
Post.create("deleteOccurrence", { id: data.id });

// Criar aviso
Post.create("createAnnounce", {
  title: title,
  message: message,
}).then((resp) => {
  setAnnounce(resp);
});
```

---

## 2. observe

Observa eventos enviados do backend para o NUI (via `SendNuiMessage`).

```ts
import { observe } from "@/hooks/observe";

observe("setVisibility", (route) => {
  // Executa quando o backend envia { action: "setVisibility", data: ... }
});

observe("setColor", (color) => {
  document.documentElement.style.setProperty("--main-color", color);
});
```

- O primeiro parâmetro é o nome da ação.
- O segundo é a função que será chamada com os dados recebidos.

---

## 3. listen

Observa eventos do DOM (ex: teclado, mouse) no NUI.

```ts
import { listen } from "@/hooks/listen";

listen("keydown", (e) => {
  if (e.code === "Escape") {
    // Fechar modal, etc
  }
});
```

- O primeiro parâmetro é o tipo do evento (ex: "keydown").
- O segundo é a função callback.
- O terceiro (opcional) é o alvo do evento (default: window).

---

## Exemplos de uso

Veja exemplos práticos nos arquivos das páginas e modais, como:

- `src/pages/Home/index.tsx`
- `src/pages/Occurrence/index.tsx`
- `src/components/_components/Modals/AnnounceModal/index.tsx`

---

## Rodando o projeto

```bash
yarn install
yarn dev
```

Abra o projeto no navegador ou use integrado ao seu servidor FiveM.

---

Feito por Rael & Thzin & Limiro 💖

---

### Lista completa de usos de `Post.create`

#### src/pages/Home/index.tsx

```ts
Post.create("getWarns", {}, warnsMockup).then((resp) => {
  setAnnounce(resp);
});

Post.create(
  "bsPolice:backend",
  { action: "statistics" },
  statisticsMockupDate,
).then((statistics) => {
  // uso dos dados
});
```

#### src/pages/Members/index.tsx

```ts
Post.create("getMembers", {}, membersMockup).then((resp) => {
  setMembers(resp);
});

Post.create("leaveOrg");
```

#### src/pages/Wanted/index.tsx

```ts
Post.create("getWantedUsers", {}, wantedUserMockup).then((resp) => {
  setUsers(resp);
});
Post.create("getWantedVehicles", {}, wantedVehicleMockup).then((resp) => {
  setVehicles(resp);
});
```

#### src/pages/Occurrence/index.tsx

```ts
Post.create("getOccurrences", {}, occurrencesMockup).then((resp) => {
  setOcurrences(resp);
});
Post.create("getOptionsOccurrence", {}, optionsMockupOccurrence).then(
  (resp) => {
    setOptions(resp);
  },
);
Post.create("deleteOccurrence", { id: data.id });
```

#### src/pages/Locked/index.tsx

```ts
Post.create("getOptions", {}, optionsMockup).then((resp) => {
  setOptions(resp);
});
```

#### src/pages/Fine/index.tsx

```ts
Post.create("getOptionsFine", {}, optionsMockupFine).then((resp) => {
  setOptions(resp);
});
```

#### src/pages/Search/index.tsx

```ts
Post.create("getPlayers").then((resp) => {
  setPlayers(resp);
});

Post.create("removeHistory", {
  time: data.time,
  id: data.id,
});
```

#### src/components/\_components/Modals/AddMember/index.tsx

```ts
Post.create("addMember", { id: value });
```

#### src/components/\_components/Modals/AnnounceModal/index.tsx

```ts
Post.create("createAnnounce", {
  title: title,
  message: message,
}).then((resp: any) => {
  setAnnounce(resp);
});
```

#### src/components/\_components/Modals/FineModal/index.tsx

```ts
Post.create("confirmPrison", {
  users: selected,
  description: value,
});
```

#### src/components/\_components/Modals/OccurrenceModal/index.tsx

```ts
Post.create("confirmOccurrence", {
  occurrence: selected,
  description: value,
});
```

#### src/components/\_components/Modals/PrisionModal/index.tsx

```ts
Post.create("confirmPrison", {
  users: selected,
  description: value,
});
```

#### src/components/\_components/Modals/WantedUserModal/index.tsx

```ts
Post.create("confirmWantedUser", {
  name: name,
  description: description,
  lastSeen: lastSeen,
  location: location,
});
```

#### src/components/\_components/Modals/WantedVehicleModal/index.tsx

```ts
Post.create("confirmWantedUser", {
  name: name,
  description: description,
  lastSeen: lastSeen,
  location: location,
});
```

#### src/pages/Members/\_components/Member.tsx

```ts
Post.create("watchPlayer", { id: data.id });
```

#### src/providers/Visibility.tsx

```ts
Post.create("removeFocus");
```

---

Se quiser, posso inserir essa lista automaticamente no README.md ou gerar para outras funções também!
