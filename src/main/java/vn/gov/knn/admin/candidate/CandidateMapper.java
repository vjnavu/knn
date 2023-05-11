package vn.gov.knn.admin.candidate;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CandidateMapper {
    List<Candidate> getListCandidate(Candidate candidate);

    int countCandidate(Candidate candidate);

    int saveNewCandidate(Candidate candidate);

    Candidate getCandidateBySeq(int cddSeq);

    int updateCandidate(Candidate candidate);

    int deleteCandidate(int candidateSeq);

    List<Candidate> getCddByExam(Candidate candidate);

    int countAllCandidate(Candidate candidate);
}
