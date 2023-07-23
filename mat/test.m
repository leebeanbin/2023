% 폴더 경로 설정
folder_path = '/Users/leejungbin/Documents/MATLAB/trainmodi/';
compare_path = '/Users/leejungbin/Desktop/train_set/';

% 이미지 파일 경로
file_path = fullfile(folder_path, 'trainmodi0000.tif');
compf_path1 = fullfile(compare_path, '0001 (1).jpeg');

% 이미지 로드
img_data = imread(file_path);
img2_data = imread(compf_path1);

% 이진화
BW = imbinarize(img_data); 
BW2 = imbinarize(img2_data); 

% 객체 라벨링
CC = bwconncomp(BW);
L = labelmatrix(CC);

CC2 = bwconncomp(BW2);
L2 = labelmatrix(CC2);

% 라플라시안 필터 생성
sharpCoeff = [0 -1 0; -1 5 -1; 0 -1 0];

% 라플라시안 필터를 이미지에 적용하여 이미지 선명하게 만들기
imgSharp = imfilter(img_data, sharpCoeff, 'symmetric');
imgSharp2 = imfilter(img2_data, sharpCoeff, 'symmetric');

% 라벨링된 결과 시각화
RGB = label2rgb(L,'spring','c','shuffle');
RGB2 = label2rgb(L2,'spring','c','shuffle');

figure
subplot(2, 2, 1);
imshow(img_data);
title('원본 이미지 1');

subplot(2, 2, 2);
imshow(img2_data);
title('원본 이미지 2');

subplot(2, 2, 3);
imshow(imgSharp);
title('라플라시안 필터링된 이미지 1');

subplot(2, 2, 4);
imshow(imgSharp2);
title('라플라시안 필터링된 이미지 2');

% 객체 개수 출력
num_bubbles = max(L(:));
num_bubbles2 = max(L2(:));

total = num_bubbles - num_bubbles2;
fprintf('버블의 개수 차이 = %d\n', total);
