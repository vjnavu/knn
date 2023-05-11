package vn.gov.knn.admin.board.board;

import lombok.Data;
import vn.gov.knn.admin.support.Paging;

import java.util.Date;

@Data
public class Board extends Paging {
    private int board_seq;
    private String board_name;
    private String board_type;
    private String board_perm_write;
    private String board_perm_view_list;
    private String board_perm_view_post;
    private String board_perm_delete;
    private int board_files;
    private String board_display;
    private int board_reg_adm;
    private Date board_reg_dt;
    private int board_mod_adm;
    private Date board_mod_dt;
    private String board_delete;

    private boolean board_display_tf;
    private String board_reg_email;
    private String board_mod_email;
    private int number_board;
}
