package vn.gov.knn.admin.album;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.gov.knn.admin.board.board.Board;
import vn.gov.knn.admin.board.board.BoardService;
import vn.gov.knn.admin.exam.Exam;
import vn.gov.knn.admin.exam.ExamService;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;
import vn.gov.knn.admin.support.CurrentUser;
import vn.gov.knn.admin.support.Pagination;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class AlbumController extends CurrentUser {
    @Autowired
    private AlbumService albumService;

    @Autowired
    private FileService fileService;

    @Autowired
    private ExamService examService;
    @Autowired
    private BoardService boardService;

    @GetMapping(value = "/cms/album")
    public String getAlbum(@ModelAttribute(value = "albumSearch") Album album, Model model) {
        super.updateRoleSession();
        List<Album> albums = albumService.getListAlbum(album);
        int totalRow = albumService.countAlbum(album);
        Pagination pagination = new Pagination();
        List<Board> boardList = boardService.getAllBoard();
        model.addAttribute("boardList", boardList);
        model.addAttribute("paging", pagination.createPagingString(album.getPage(), album.getSize(), totalRow));
        model.addAttribute("albums", albums);
        return "/vn/admin/album/list";
    }

    @GetMapping(value = "/cms/album/new")
    public String newAlbum(Model model) {
        super.updateRoleSession();
        List<Exam> exams = examService.getAllExam();

        model.addAttribute("exams", exams);
        model.addAttribute("albumForm", new Album());
        model.addAttribute("formAction", "new");
        return "/vn/admin/album/form";
    }

    @PostMapping(value = "/cms/album/new")
    public String saveAlbum(RedirectAttributes redirectAttributes, @ModelAttribute("albumForm") Album albumForm, @RequestParam(name = "imgs") MultipartFile[] album) throws Exception {
        albumForm.setAlbum_regis(new Date());
        if (album != null && album.length > 0) {
            String strAlbum = "";
            for (int i = 0; i < album.length; i++) {
                FileVO fileVO = new FileVO();
                fileVO.setTarget_dir("/album/");
                fileService.saveFile(album[i], fileVO);
                strAlbum = strAlbum + String.valueOf(fileVO.getFile_seq() + ",");
            }
            strAlbum = strAlbum.substring(0, strAlbum.length() - 1);
            albumForm.setAlbum_img(strAlbum);
        }
        int saveResult = albumService.saveNewAlbum(albumForm);
        if (saveResult > 0) redirectAttributes.addFlashAttribute("successMess", "Thêm album thành công");
        else redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi thêm album");
        return "redirect:/cms/album";
    }

    @GetMapping("/cms/album/delete/{albumSeq}")
    public String deleteAlbum(@PathVariable int albumSeq, RedirectAttributes redirectAttributes) throws IOException {
        int delAlbum = albumService.deleteAlbum(albumSeq);
        if (delAlbum > 0) redirectAttributes.addFlashAttribute("successMess", "Xoá album thành công");
        else redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi xoá album");
        return "redirect:/cms/album";
    }

    @GetMapping("/cms/album/update/{albumSeq}")
    public String updateAlbum(@PathVariable int albumSeq, Model model) {
        Album album = albumService.getAlbumBySeq(albumSeq);
        List<Exam> exams = examService.getAllExam();

        List<FileVO> fileVOS = new ArrayList<>();
        if (album.getAlbum_img().length() > 0) {
            int[] img = Arrays.stream(album.getAlbum_img().split(",")).mapToInt(Integer::parseInt).toArray();
            if (img != null && img.length > 0) {
                for (int i : img) {
                    FileVO fileVO = fileService.getFileBySeq(i);
                    fileVOS.add(fileVO);
                }
            }
        }
        album.setAlbum(fileVOS);

        model.addAttribute("formAction", "update");
        model.addAttribute("albumForm", album);
        model.addAttribute("exams", exams);
        return "/vn/admin/album/form";
    }

    @PostMapping("/cms/album/update")
    public String updateSaveAlbum(@ModelAttribute(value = "albumForm") Album album,
                                  @RequestParam(value = "imgs") MultipartFile[] albumImg,
                                  RedirectAttributes redirectAttributes
    ) throws Exception {
        Album albumOld = albumService.getAlbumBySeq(album.getAlbum_seq());
        if (albumOld.getAlbum_img() != "" && albumOld.getAlbum_img() != null) {
            if (albumOld.getAlbum_img().length() > 0) {
                if (albumOld.getAlbum_img().contains(",")) {
                    List<Integer> oldImage = Arrays.asList(albumOld.getAlbum_img().split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());
                    List<Integer> currentImage = Arrays.asList(album.getAlbum_img().split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());
                    String listString = currentImage.toString();
                    String albumStr = "";
                    if (currentImage.size() == 1) albumStr = String.valueOf(currentImage.get(0));
                    else albumStr = listString.substring(1, listString.length() - 1);

                    if (albumImg != null && !albumImg[0].getOriginalFilename().equals("")) {
                        for (MultipartFile f : albumImg) {
                            FileVO fileVO = new FileVO();
                            fileVO.setTarget_dir("/album/");
                            fileService.saveFile(f, fileVO);
                            if (albumImg.length > 0) albumStr = albumStr + "," + fileVO.getFile_seq();
                            else albumStr += fileVO.getFile_seq();
                        }
                    }
                    oldImage.removeAll(currentImage);
                    if (oldImage.size() > 0) {
                        for (Integer seq : oldImage) {
                            fileService.deleteFileBySeq(seq);
                        }
                    }
                    albumStr = albumStr.replaceAll(" ", "");
                    album.setAlbum_img(albumStr);
                }
            }
        }
        album.setAlbum_mod_dt(new Date());
        int updateResult = albumService.updateSave(album);
        if (updateResult > 0) redirectAttributes.addFlashAttribute("successMess", "Cập nhật album thành công");
        else redirectAttributes.addFlashAttribute("errorMess", "Đã xảy ra lỗi khi cập nhật album");
        return "redirect:/cms/album";
    }
}
