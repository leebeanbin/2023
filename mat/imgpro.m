folder_path = '/Users/leejungbin/Desktop/train_set/trainmodi/';
% 내가 보려고 하는 사진의 경로

% 폴더 내의 모든 파일 목록 가져오기
file_list = dir(fullfile(folder_path, '*.tiff'));  % .tif 확장자를 가진 파일만 가져옴

% 파일 개수 확인
num_files = length(file_list);

% 결과 출력
% fprintf('폴더 내의 이미지 파일 개수: %d\n', num_images);

% 이미지를 저장할 셀 배열 선언
images = cell(1, num_files);

% 파일들을 순회하며 이미지 로드
for i = 1:num_files
    file_name = file_list(i).name;
    file_path = fullfile(folder_path, file_name);
    
    % 이미지 로드
    image_data = imread(file_path);
    
    % 이미지를 셀 배열에 저장
    images{i} = image_data;
end
