*&---------------------------------------------------------------------*
*& Include          ZALV_OO_WFG_TOP
*&---------------------------------------------------------------------*
TABLES: ztbaluno_wfg.

TYPE-POOLS: slis.

TYPES: BEGIN OF ty_alunos,
         matricula TYPE ztbaluno_wfg-matricula,
         nome      TYPE ztbaluno_wfg-nome,
         nota1     TYPE ztbaluno_wfg-nota1,
         nota2     TYPE ztbaluno_wfg-nota2,
         nota3     TYPE ztbaluno_wfg-nota3,
         media     TYPE ztbaluno_wfg-media,
         situacao  TYPE ztbaluno_wfg-situacao,
       END OF ty_alunos.

DATA: gt_alunos TYPE TABLE OF ty_alunos,
      gs_alunos TYPE ty_alunos.

DATA: fieldcatalog TYPE slis_t_fieldcat_alv.
DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
      wa_fieldcat  TYPE lvc_s_fcat,
      gd_tab_group TYPE slis_t_sp_group_alv,
      gd_layout    TYPE lvc_s_layo,
      gd_repid     LIKE sy-repid.