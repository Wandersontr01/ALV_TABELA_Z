*&----------------------------------------------------------------------*
*&                        Report ZALV_OO_WFG                            *
*&----------------------------------------------------------------------*
*&                   MEGAWORK Consultoria  - Treinamento                *
*&----------------------------------------------------------------------*
*& Report.....: ZMMR_RECEB_MERCADORIA_EDOC                              *
*& Autor......: Wanderson Franca                                        *
*& Data.......: 27/06/2024                                              *
*& Descrição  : Treinando relatório ALV                                 *
*&                                                                      *
*& Projeto....: N/A                                                     *
*&----------------------------------------------------------------------*
*&                     Histórico das modificações                       *
*&----------------------------------------------------------------------*
*&   Data     |  Nome            | Request    | Descrição               *
*&----------------------------------------------------------------------*
*& 27/06/2024  |Wanderson Franca |            | Desenvolvimento inicial *
*&----------------------------------------------------------------------*
*& Informações adicionais de regras da implementação                    *
*&----------------------------------------------------------------------*
REPORT zalv_oo_wfg.

INCLUDE: zalv_oo_wfg_top,
         zalv_oo_wfg_f01.

START-OF-SELECTION.
  PERFORM f_data_retrieval.
  PERFORM f_build_fieldcatalog.
  PERFORM f_build_layout.
  PERFORM f_display_alv_report.