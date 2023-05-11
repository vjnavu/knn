package vn.gov.knn.admin.exam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.album.Album;
import vn.gov.knn.admin.album.AlbumService;
import vn.gov.knn.admin.file.FileService;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Service
public class ExamService {
    @Autowired
    private ExamMapper examMapper;
    @Autowired
    private FileService fileService;

    @Autowired
    private AlbumService albumService;

    public List<Exam> getListExam(Exam exam) {
        exam.setOffset((exam.getPage() - 1) * exam.getSize());
        return examMapper.getListExam(exam);
    }

    public int countExam(Exam exam) {
        return examMapper.countExam(exam);
    }

    public int saveNewExam(Exam exam) {
        return examMapper.saveNewExam(exam);
    }

    public int deleteExam(int examSeq) throws IOException {
        Exam examDelete = this.getExamBySeq(examSeq);
        if (examDelete != null) {
            if (examDelete.getExam_logo() != 0)
                fileService.deleteFileBySeq(examDelete.getExam_logo());
            if (examDelete.getExam_candi() != 0)
                fileService.deleteFileBySeq(examDelete.getExam_candi());
            List<Album> albums = albumService.getAlbumsByExamSeq(examSeq);
            if (albums.size() > 0) {
                for (Album album : albums) {
                    if (album.getAlbum_img() != null) {
                        if (album.getAlbum_img().length() > 0) {
                            if (album.getAlbum_img().contains(",")) {
                                int[] arAb = Arrays.stream(album.getAlbum_img().split(",")).mapToInt(Integer::parseInt).toArray();
                                if (arAb != null && arAb.length > 0) {
                                    for (int i : arAb) {
                                        fileService.deleteFileBySeq(i);
                                    }
                                }
                            } else {
                                fileService.deleteFileBySeq(Integer.parseInt(album.getAlbum_img()));
                            }
                        }
                    }
                    albumService.deleteAlbum(album.getAlbum_seq());
                }
            }
        }
        return examMapper.deleteExam(examSeq);
    }

    public Exam getExamBySeq(int examSeq) {
        return examMapper.getExamBySeq(examSeq);
    }

    public int updateExam(Exam exam) {
        return examMapper.updateExam(exam);
    }

    public List<Exam> getAllExam() {
        return examMapper.getAllExam();
    }

    public List<Exam> getListExamByExamType(Exam exam) {
        exam.setOffset((exam.getPage() - 1) * exam.getSize());
        return examMapper.getListExamByExamType(exam);
    }

    public Exam getExamByLimit(int limit, String type) {
        return examMapper.getExamByLimit(limit, type);
    }
}
