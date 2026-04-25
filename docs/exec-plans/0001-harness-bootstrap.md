# 0001 하네스 부트스트랩

상태: done

## 목표

이후 Codex나 사람이 구현 작업을 진행할 때 안정적으로 검색하고 검증할 수 있는
레포 하네스를 만든다.

## 범위

- 루트 `AGENTS.md`를 짧은 에이전트 진입점으로 추가한다.
- 제품 요구사항과 하네스 참고 문서를 버전 관리되는 `docs/` 안으로 옮긴다.
- `Makefile`로 로컬 검증 명령을 제공한다.
- Flutter 포맷, 정적 분석, 테스트를 실행하는 GitHub Actions CI를 추가한다.

## 주요 결정

- PRD와 하네스 가이드는 레포 밖 파일에 의존하지 않고 레포 내부로 복사한다.
- Flutter 아키텍처 규칙은 이 단계에서 가볍게 문서로만 둔다.
- 이 부트스트랩 단계에서는 PRD 화면이나 상태 구현을 하지 않는다.
- 기본 로컬 검증 명령은 `make check`로 둔다.

## 구현 개요

- `docs/product`, `docs/references`, `docs/architecture`, `docs/exec-plans`,
  `docs/quality`, `docs/reliability`를 만든다.
- `AGENTS.md`에 프로젝트 목표, P0 우선 규칙, 과구현 금지, 검증 명령,
  문서 지도를 적는다.
- Flutter 의존성 설치, 포맷, 분석, 테스트 명령을 감싸는 `Makefile`을 추가한다.
- `.github/workflows/flutter-check.yml`을 추가한다.

## 검증

- `make check`
- `flutter test`
- 커밋 전 `git status --short`로 의도한 하네스 파일만 변경됐는지 확인한다.
