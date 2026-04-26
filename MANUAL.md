# Manual de Atajos — Neovim

> Leader = `Space` · Teclado: Split 32 teclas · Layout: Colemak Mod-DH

---

## Criterio de diseño de atajos

Los atajos están diseñados para **Colemak Mod-DH**. Las teclas más frecuentes
usan la fila home (`A R S T | N E I O`):

- Splits: `<leader>a/n/u/i` — las cuatro teclas de dirección en posición cómoda
- Mover líneas: `Alt+n/e` — equivalentes físicos de `j/k` en Colemak

---

## Explorador de archivos

### NERDTree

| Atajo          | Acción                                  |
|----------------|-----------------------------------------|
| `<leader>e`    | Abrir/cerrar árbol de archivos          |
| `<leader>E`    | Revelar archivo actual en el árbol      |

### oil.nvim (file manager editable como buffer)

| Atajo          | Acción                                  |
|----------------|-----------------------------------------|
| `<leader>o`    | Abrir panel flotante                    |
| `<CR>`         | Abrir archivo/directorio               |
| `<BS>` / `-`   | Subir al directorio padre               |
| `_`            | Ir al directorio de trabajo (cwd)       |
| `g.`           | Mostrar/ocultar archivos ocultos        |
| `q`            | Cerrar                                  |
| `g?`           | Ayuda                                   |

> Renombrar, mover o borrar archivos: edita el buffer y guarda con `:w`

---

## Splits (ventanas)

| Atajo          | Acción              | Posición Colemak  |
|----------------|---------------------|-------------------|
| `<leader>a`    | Split izquierdo     | pinky izq home    |
| `<leader>n`    | Split abajo         | índice der home   |
| `<leader>u`    | Split arriba        | fila sup der      |
| `<leader>i`    | Split derecho       | anular der home   |

---

## Buffers (pestañas)

| Atajo          | Acción                            |
|----------------|-----------------------------------|
| `<Tab>`        | Siguiente buffer                  |
| `<S-Tab>`      | Buffer anterior                   |
| `<leader>1-9`  | Saltar al buffer N                |
| `<leader>x`    | Cerrar buffer actual              |

---

## Buscador (Telescope)

| Atajo          | Acción                            |
|----------------|-----------------------------------|
| `<leader>ff`   | Buscar archivos                   |
| `<leader>fg`   | Buscar texto en proyecto (grep)   |
| `<leader>fb`   | Buscar buffer abierto             |
| `<leader>fr`   | Archivos recientes                |
| `<leader>fs`   | Símbolos LSP del archivo          |
| `<leader>nh`   | Historial de notificaciones       |

> Búsquedas potenciadas por **fzf-native** (C), notablemente más rápido en proyectos grandes.

---

## Navegación rápida (flash.nvim)

| Atajo          | Modo         | Acción                                           |
|----------------|--------------|--------------------------------------------------|
| `s`            | Normal/Visual | Saltar a cualquier posición visible (2-3 letras) |
| `S`            | Normal/Visual | Saltar por nodos de treesitter                   |
| `r`            | Operator     | Remote — ejecutar operador en destino lejano     |
| `R`            | Operator/Visual | Buscar con treesitter                         |
| `<C-s>`        | Comando      | Activar flash en búsqueda `/`                    |

> `s` reemplaza el vim nativo `s` (equivalente a `cl`).

---

## LSP (código)

| Atajo          | Acción                                    |
|----------------|-------------------------------------------|
| `gd`           | Ir a definición                           |
| `gD`           | Ir a declaración                          |
| `gi`           | Ir a implementación                       |
| `gr`           | Ver referencias                           |
| `K`            | Peek fold si existe, sino hover LSP       |
| `<leader>rn`   | Renombrar símbolo                         |
| `<leader>ca`   | Acciones de código                        |
| `<leader>d`    | Diagnóstico flotante                      |
| `]d`           | Siguiente diagnóstico                     |
| `[d`           | Diagnóstico anterior                      |
| `<leader>gt`   | Ir a definición en nueva tab              |
| `Ctrl+Click`   | Ir a definición en nueva tab              |

> **Breadcrumbs:** la winbar muestra automáticamente `archivo > clase > función` cuando hay LSP activo (barbecue + navic).

---

## Folds (nvim-ufo)

| Atajo  | Acción                              |
|--------|-------------------------------------|
| `zR`   | Abrir todos los folds               |
| `zM`   | Cerrar todos los folds              |
| `zr`   | Abrir folds del nivel actual        |
| `zm`   | Cerrar folds del nivel actual       |
| `za`   | Toggle fold bajo el cursor          |
| `K`    | Peek del fold cerrado (sin abrirlo) |

> Los folds usan treesitter/LSP y muestran cuántas líneas contienen.

---

## Git — Hunks (gitsigns.nvim)

| Atajo          | Acción                                  |
|----------------|-----------------------------------------|
| `]g`           | Siguiente hunk                          |
| `[g`           | Hunk anterior                           |
| `<leader>gp`   | Preview del hunk                        |
| `<leader>gs`   | Stage del hunk                          |
| `<leader>gu`   | Undo del hunk                           |
| `<leader>gB`   | Toggle blame inline (por línea)         |
| `<leader>gS`   | Stage del buffer completo               |
| `<leader>gR`   | Reset del buffer completo               |
| `<leader>gi`   | Diff del archivo actual                 |
| `ih`           | Text object: seleccionar hunk actual    |

---

## Git — Comandos (vim-fugitive)

| Atajo          | Acción                            |
|----------------|-----------------------------------|
| `<leader>gg`   | Panel Git (status)                |
| `<leader>gb`   | Git blame (buffer completo)       |
| `<leader>gL`   | Git log (oneline)                 |

---

## Git — Diffs visuales (diffview.nvim)

| Atajo          | Acción                                      |
|----------------|---------------------------------------------|
| `<leader>gd`   | Abrir vista de cambios (todos los archivos) |
| `<leader>gD`   | Cerrar diffview                             |
| `<leader>gf`   | Historial del archivo actual                |
| `<leader>gH`   | Historial completo del repositorio          |

**Dentro de diffview:**
- `Tab` / `S-Tab` — navegar entre archivos modificados
- `[x` / `]x` — saltar al conflicto anterior/siguiente
- `q` — cerrar el panel

---

## Sesiones (vim-obsession)

| Atajo          | Acción                                                          |
|----------------|-----------------------------------------------------------------|
| `<leader>ss`   | Iniciar/pausar grabación de sesión en `.session.vim`            |
| `<leader>sr`   | Retomar sesión desde `.session.vim` en el directorio actual     |

**Flujo típico:**
1. Abrir el proyecto: `nvim`
2. `<leader>ss` para empezar a grabar (lualine muestra `[S]`)
3. Abrir archivos, splits, etc. — todo se guarda automáticamente
4. La próxima vez: `nvim -S .session.vim` o `<leader>sr`
5. `<leader>ss` de nuevo para pausar/reanudar la grabación

**Desde terminal:**
```
nvim -S .session.vim      # retomar sesión al abrir nvim
```

---

## Edición

| Atajo             | Acción                            |
|-------------------|-----------------------------------|
| `Alt+n`           | Mover línea/bloque abajo          |
| `Alt+e`           | Mover línea/bloque arriba         |
| `Alt+Down`        | Mover línea/bloque abajo          |
| `Alt+Up`          | Mover línea/bloque arriba         |
| `gcc`             | Comentar/descomentar línea        |
| `gc` (visual)     | Comentar/descomentar selección    |
| `ys<obj><char>`   | Rodear con delimitador            |
| `ds<char>`        | Eliminar delimitador              |
| `cs<old><new>`    | Cambiar delimitador               |

---

## Colores (ccc.nvim)

| Atajo          | Acción                                              |
|----------------|-----------------------------------------------------|
| `<leader>cc`   | Abrir color picker sobre el color bajo el cursor    |

> Preview inline automático en CSS, SCSS, HTML, JS/TS y Lua. El picker permite cambiar el formato de salida (hex, rgb, hsl).

---

## Formateo (conform.nvim + Prettier)

| Atajo          | Acción                                |
|----------------|---------------------------------------|
| `<leader>p`    | Formatear buffer o selección actual   |

> Formatea JS, TS, TSX, CSS, SCSS, HTML, JSON, Markdown y YAML con Prettier.

---

## Copilot (IA)

| Atajo      | Acción                     |
|------------|----------------------------|
| `Tab`      | Aceptar sugerencia         |
| `Alt+]`    | Siguiente sugerencia       |
| `Alt+[`    | Sugerencia anterior        |
| `Ctrl+\`   | Descartar sugerencia       |

---

## Terminal

| Atajo              | Acción                              |
|--------------------|-------------------------------------|
| `<leader>tc`       | Abrir terminal lateral con Claude   |
| `<leader>tg`       | Abrir terminal lateral con Gemini   |
| `<leader>tt`       | Abrir terminal lateral limpio       |
| `Esc Esc`          | Salir de modo terminal (sin cerrar) |

---

## Búsqueda

| Atajo    | Acción                          |
|----------|---------------------------------|
| `Esc`    | Limpiar highlight de búsqueda   |

---

## Indentación (visual)

| Atajo      | Acción                                 |
|------------|----------------------------------------|
| `<`        | Indentar izquierda (mantiene selección)|
| `>`        | Indentar derecha (mantiene selección)  |
| `Tab`      | Indentar derecha (mantiene selección)  |
| `S-Tab`    | Indentar izquierda (mantiene selección)|

---

## Which-key

Pausa `Space` en normal mode para ver un popup con todos los atajos disponibles y sus descripciones agrupadas por prefijo.
