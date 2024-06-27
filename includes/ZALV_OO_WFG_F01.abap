*&---------------------------------------------------------------------*
*& Include          ZALV_OO_WFG_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form f_data_retrieval
*&---------------------------------------------------------------------*
*& Select na tabela de alunos com os campos desejados
*&---------------------------------------------------------------------*
FORM f_data_retrieval .
  SELECT matricula, nome, nota1, nota2, nota3, media, situacao FROM ztbaluno_wfg INTO TABLE @gt_alunos.
ENDFORM.                 "f_data_retrieval

*&---------------------------------------------------------------------*
*& Form f_build_fieldcatalog
*&---------------------------------------------------------------------*
*& Constroi fieldcat
*&---------------------------------------------------------------------*
FORM f_build_fieldcatalog .
  it_fieldcat = VALUE #( BASE it_fieldcat (
                                                     fieldname = 'MATRICULA' outputlen = 5  reptext_ddic = 'Matricula'              )
                                                  (  fieldname = 'NOME'      outputlen = 11 reptext_ddic = 'Nome'                   )
                                                  (  fieldname = 'NOTA1'     outputlen = 7  reptext_ddic = 'Nota1' edit = abap_true )
                                                  (  fieldname = 'NOTA2'     outputlen = 7  reptext_ddic = 'Nota2' edit = abap_true )
                                                  (  fieldname = 'NOTA3'     outputlen = 7  reptext_ddic = 'Nota3' edit = abap_true )
                                                  (  fieldname = 'MEDIA'     outputlen = 7  reptext_ddic = 'Média'                  )
                                                  (  fieldname = 'SITUACAO'  outputlen = 10 reptext_ddic = 'Situação'               ) ).

ENDFORM.                 "f_build_fieldcatalog

*&---------------------------------------------------------------------*
*& Form f_build_layout
*&---------------------------------------------------------------------*
*& Constroi layout
*&---------------------------------------------------------------------*
FORM f_build_layout .
* Set layout field for field attributes(i.e. input/output)
  gd_layout-stylefname = 'FIELD_STYLE'.
  gd_layout-zebra             = 'X'.
ENDFORM.                 "f_build_layout

*&---------------------------------------------------------------------*
*& Form f_display_alv_report
*&---------------------------------------------------------------------*
*& Apresenta alv na tela
*&---------------------------------------------------------------------*
FORM f_display_alv_report .
  gd_repid = sy-repid.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = gd_repid
      it_fieldcat              = it_fieldcat
      i_callback_pf_status_set = 'F_PF_STATUS_ALV'
      i_callback_user_command  = 'F_USER_COMMAND'
    TABLES
      t_outtab                 = gt_alunos
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
ENDFORM.                 "f_display_alv_report

*&---------------------------------------------------------------------*
*& Form _user_command
*&---------------------------------------------------------------------*
*& Captura ação no botão do STATUSGUI
*&---------------------------------------------------------------------*
FORM f_user_command USING r_ucomm     LIKE sy-ucomm
                          rs_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN 'ATUALIZAR'.
      PERFORM f_atualizar_media.
      PERFORM f_display_alv_report.
      MESSAGE: 'TESTE' TYPE 'I' DISPLAY LIKE 'S'.
  ENDCASE.

ENDFORM.                 "z_user_command

*&---------------------------------------------------------------------*
*& Form _user_command
*&---------------------------------------------------------------------*
*& Seta o Statusgui Z importado
*&---------------------------------------------------------------------*
FORM f_pf_status_alv USING rt_extab TYPE slis_t_extab.
  DELETE rt_extab WHERE fcode = '&RNT_PREV'.
  SET PF-STATUS 'ZSTATUSGUI' EXCLUDING rt_extab.
ENDFORM.                 "f_pf_status_alv

*&---------------------------------------------------------------------*
*& Form f_atualizar_media
*&---------------------------------------------------------------------*
*& Atualiza a média do aluno com base nos campos editados na ALV
*& é instânciado um objeto do aluno para que seja atualizado a situação
*& com base nas notas.
*&---------------------------------------------------------------------*
FORM f_atualizar_media .
  DATA: lcl_alunos TYPE REF TO zcl_aluno_wfg.

  LOOP AT gt_alunos ASSIGNING FIELD-SYMBOL(<fs_aluno>).
    <fs_aluno>-media = ( <fs_aluno>-nota1 + <fs_aluno>-nota2 + <fs_aluno>-nota3 ) / 3.

      CREATE OBJECT lcl_alunos
    EXPORTING
      i_matricula = <fs_aluno>-matricula
      i_nota1     = <fs_aluno>-nota1
      i_nota2     = <fs_aluno>-nota2
      i_nota3     = <fs_aluno>-nota3
      i_nome      = 'Nome Qualquer'.

    lcl_alunos->get_situacao( RECEIVING r_situacao = DATA(lv_situacao) ).
    <fs_aluno>-situacao = lv_situacao.

    MODIFY gt_alunos FROM <fs_aluno>.
  ENDLOOP.
ENDFORM.                 "f_atualizar_media