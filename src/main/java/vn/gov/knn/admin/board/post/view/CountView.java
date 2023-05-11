package vn.gov.knn.admin.board.post.view;

public class CountView {
  private int vp_seq;
  private int post_seq;
  private String vp_session_id;

  public CountView() {}

  public int getVp_seq() {
    return vp_seq;
  }

  public void setVp_seq(int vp_seq) {
    this.vp_seq = vp_seq;
  }

  public int getPost_seq() {
    return post_seq;
  }

  public void setPost_seq(int post_seq) {
    this.post_seq = post_seq;
  }

  public String getVp_session_id() {
    return vp_session_id;
  }

  public void setVp_session_id(String vp_session_id) {
    this.vp_session_id = vp_session_id;
  }
}
