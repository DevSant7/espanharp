-- =====================================================
-- KILLFEED — Shared Config
-- =====================================================
-- Authoritative list of every routable killfeed context.
-- Adding a context here is enough for the router to accept
-- it both on server and client.
-- =====================================================

Killfeeds = {
    global = {
        enabled    = true,
        duration   = 6, -- seconds
        maxEntries = 6,
    },

    helicrash = {
        enabled    = true,
        duration   = 8, -- seconds
        maxEntries = 6,
    },

    airdrop = {
        enabled    = true,
        duration   = 8, -- seconds
        maxEntries = 6,
    },

    event = {
        enabled    = true,
        duration   = 8, -- seconds
        maxEntries = 6,
    },

    ffa = {
        enabled    = true,
        duration   = 6, -- seconds
        maxEntries = 6,
    },

    arena = {
        enabled    = true,
        duration   = 8, -- seconds
        maxEntries = 6,

        -- Contexto PRIVADO: o bridge automatico ("killfeed:reportKill") NAO
        -- distribui nada aqui. A arena roda varias partidas em paralelo, cada
        -- uma na sua dimensao; um fan-out por contexto misturaria as mortes de
        -- todas elas. Quem manda o feed e o proprio europa_arena, chamando
        -- broadcastKillToSources so para os jogadores/espectadores DAQUELA
        -- partida.
        private    = true,
    },
}

KILLFEED_DEFAULT_CONTEXT = "global"
