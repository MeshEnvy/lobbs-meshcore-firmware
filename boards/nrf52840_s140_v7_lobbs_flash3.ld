/* Opt-in LoBBS /flash3: 32 KiB at 0xCC000-0xD4000, below MeshCore ExtraFS at 0xD4000.
 * Point board_build.ldscript at this file instead of nrf52840_s140_v7_extrafs.ld.
 */

SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
  FLASH (rx)     : ORIGIN = 0x27000, LENGTH = 0xCC000 - 0x27000
  RAM (rwx) :  ORIGIN = 0x20006000, LENGTH = 0x20040000 - 0x20006000
}

SECTIONS
{
  . = ALIGN(4);
  .svc_data :
  {
    PROVIDE(__start_svc_data = .);
    KEEP(*(.svc_data))
    PROVIDE(__stop_svc_data = .);
  } > RAM

  .fs_data :
  {
    PROVIDE(__start_fs_data = .);
    KEEP(*(.fs_data))
    PROVIDE(__stop_fs_data = .);
  } > RAM
} INSERT AFTER .data;

PROVIDE(__flash3_start = 0xCC000);
PROVIDE(__flash3_end = 0xD4000);

INCLUDE "nrf52_common.ld"
