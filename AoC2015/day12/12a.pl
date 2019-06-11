use strict;
use warnings;

use List::Util qw(sum);

my @array = (161, -14, -35, 0, 70, 12, 69, 92, 121, 14, 46, 62, 179, 133, 151, 93, 135, 43, 54, 69, 159, 2, 65, 126, 106, 190, -40, 134, 87, -3, 50, 120, 138, 83, 177, 98, 179, 23, 108, 17, -46, 3, 99, -43, 46, 192, 39, 57, 195, 172, 97, 160, 120, 61, 186, 82, -5, -13, 12, -19, 82, 3, 45, 198, 81, 193, 99, 64, 98, 30, 167, 168, 173, 90, 10, 3, 195, 143, -26, 136, -28, 137, 108, 70, 19, -11, 188, 173, 135, 148, 108, 188, 145, 118, 17, 55, 86, -20, 118, 62, -41, 5, 33, 87, 147, 91, -4, 19, -38, -10, 29, 52, 54, -14, -2, 12, 180, 186, 103, 119, 116, 22, 44, 144, 119, 10, 15, 115, 55, 85, 135, -12, 61, 34, 0, -37, -21, 123, 106, 100, 164, 120, 54, -22, 130, 198, 82, 2, 151, 128, 88, 72, 194, 4, 149, 27, 174, 50, 154, 167, 49, 76, 166, 10, 185, 53, 101, -1, 92, -20, 129, 99, 38, 98, 129, -5, 20, 87, 124, -2, 17, 161, 104, 51, 47, 57, -41, 149, -11, 103, 72, -8, 68, -43, 36, 106, 144, 166, 109, 56, -41, 36, 20, 188, -7, 155, 0, 144, 133, 10, 91, 160, 183, 18, 43, 85, -37, -35, 57, 17, 57, 29, 112, 68, 162, 42, 183, 2, 115, -31, 29, -47, 35, 25, 111, 16, -44, -22, 179, 84, 178, 183, 92, 163, 105, 24, -26, 125, 12, 144, 114, 92, 40, 67, 105, 155, 37, -38, -13, -27, 109, 57, 181, 193, -32, 83, 128, 21, 199, 35, 126, 183, 60, 105, 133, 144, 105, 72, 161, 98, 51, -6, 51, 72, 190, -13, 90, -6, 137, 61, 126, 101, 118, 13, -4, 47, 157, 77, 176, 67, 59, 140, 15, 53, 162, 47, 49, 132, 142, 75, 56, 185, 144, 121, -23, -34, 147, 127, -25, 80, 43, 34, -1, 150, 95, -4, -4, 108, 70, -1, 45, -20, -19, 90, -46, 96, 44, -43, 124, 30, 66, 125, 108, -11, 132, -33, 148, -13, 84, 10, -21, -1, 110, 51, 127, -14, 15, 102, -41, 101, 19, 61, 55, -5, 113, 35, 26, 150, 39, 152, 198, 75, 191, 131, 177, 27, 51, 129, 52, 165, 4, 15, 52, 182, 83, 167, 103, 66, 105, -19, 162, 165, 153, 115, 0, 26, 198, 15, 58, -15, -3, 113, 59, -42, 38, -2, 156, 79, 126, 64, 43, 47, 44, -15, 60, -38, 130, 34, -49, 142, 181, 35, 0, -20, 88, 171, -13, 28, 70, -30, 63, 23, 19, 105, 138, 21, -20, -26, 143, 26, 119, 179, 48, 171, 132, 92, -23, 52, 124, -19, 181, -23, -7, 139, 136, 117, 145, 175, 42, 193, -16, -43, 146, 115, 199, 150, -14, 129, 64, 86, 1, 109, 149, 30, 112, 140, 139, -8, -13, 25, 111, 127, 183, 81, 192, 105, 71, 18, 37, 184, 121, 59, 33, 154, 97, 113, 23, 125, 85, 99, 34, 100, 19, -2, 114, 72, 144, 96, 85, 125, -18, 73, 132, 146, 15, 138, 194, 104, -4, 122, -32, -28, -6, 18, -31, 44, 117, -37, 122, -31, 78, 118, 166, 167, 126, 137, 152, 14, 39, 171, 46, 137, -13, 136, 76, 148, 86, -9, 156, 119, 66, 198, -1, 34, 52, 85, -5, 96, 43, 32, 95, 119, -8, 126, 17, 178, 73, 57, 195, 23, 122, 64, 11, -18, 147, -34, -24, 51, 121, 104, 152, 99, 62, 37, 178, 112, 192, 165, 82, 61, 86, 187, 119, 17, 173, 193, 87, -1, -1, 133, 165, 68, -24, 129, 52, 173, 145, 51, 141, 129, 14, 25, 118, 6, 169, 29, 176, 79, 74, 67, 34, 47, 23, 16, -27, 48, 56, 173, 98, 147, 69, 137, 171, 1, -22, 17, -33, -30, 154, 59, 125, 84, 50, 91, -20, -13, 46, 79, 173, 107, 103, 32, 193, 6, 82, -24, 197, 25, -2, 167, -45, 55, 21, 198, 55, 44, 13, 0, 197, 69, 80, 92, 11, 158, 130, 88, 199, 176, -23, 128, 185, 142, 148, 124, 15, 1, -31, 90, 24, 177, 190, 65, -14, 146, 140, 126, -11, 158, 11, 168, 7, 107, 167, 37, -48, 179, 116, 196, 97, 107, 144, 4, 98, 147, -40, 64, 191, 178, 49, 61, 125, -41, 27, 9, 194, 138, 112, 184, -16, 115, -6, 149, -20, 50, 20, -38, 128, 160, 193, -18, 118, 183, 99, -13, 166, 20, 183, 77, 61, -31, 49, 166, -30, -33, -38, 167, 53, 145, 67, 109, 156, 189, 116, -24, 76, 45, 10, 168, -9, 93, -6, 109, 12, -35, 36, -10, 105, 31, 40, 75, 23, 187, 48, 172, 7, -2, 167, 140, 102, 62, 111, 69, 84, 114, 13, 99, -21, 88, 174, -1, 68, 119, 152, 132, 8, 61, 1, 70, 48, -39, 3, 142, 114, 82, 19, 91, 18, -24, 137, 153, 0, 45, 62, 25, 189, 38, 119, 100, -36, 157, 42, 24, 77, 135, 8, 185, 138, -16, 6, 149, 23, 192, -36, -27, -17, 81, 141, 23, 86, -22, 123, 56, 131, 156, 58, 27, 56, 35, 84, 141, 65, -17, 192, 137, 47, 95, 182, 177, 174, -11, 39, 80, 112, -19, -18, 16, -37, 21, -5, 106, 31, 146, 46, -49, -20, -9, 155, -33, 173, -1, 194, -31, 42, 121, 102, -27, 137, -23, -25, 129, 145, 34, 108, 131, 164, 6, 31, 127, 88, -40, 160, 25, 41, 44, 106, 197, 21, 115, 144, 38, -24, 148, 65, 41, 177, 118, -42, 13, 104, 32, 119, -44, 87, 58, 128, -24, 15, 165, 109, 101, 98, 78, 166, -20, 33, -9, 112, 144, 86, 176, 128, 150, 71, 47, 105, 45, 112, 196, 170, 49, 91, -40, -46, -15, 93, 18, -17, 80, 93, 199, 91, 70, -39, 198, 57, 81, 154, -37, -6, 77, 157, 75, 86, 7, -40, 139, 34, 120, 152, 119, -5, 107, 105, 104, 136, 9, 199, 48, 178, 152, 36, 89, 155, 107, 13, 160, 114, 157, 81, -48, 76, 13, 12, 76, -44, 180, 133, 13, 156, 102, -7, 21, 129, 26, 7, 33, 178, -31, 194, 9, 126, 27, 7, 91, 190, -27, 143, 3, 5, 116, 39, 81, -24, -34, -42, 188, 63, 2, 172, -44, 75, -40, 197, -21, 84, 7, 39, 98, 173, 49, 38, 184, -33, 53, 77, 166, 118, -6, 74, 47, 92, 4, 3, 167, -31, 30, 194, -34, 43, -28, 181, 175, 110, 198, 185, 183, 29, 45, 155, -39, 192, 77, -42, 57, 193, 62, 64, 58, -31, 141, 111, 167, -13, 17, 22, 167, 56, 26, 145, 6, 13, -41, 120, 187, 124, 34, 71, 82, 146, 87, 168, 117, 39, 144, 131, -28, -15, -42, 47, 99, 140, 138, 65, 185, 8, 153, -40, 93, 175, -27, -47, 48, 83, 184, 167, -27, 12, 22, -15, 34, 28, 121, 170, 13, 44, 198, 176, 23, -3, 165, 64, 189, -19, -49, 123, -6, 190, 68, 98, 68, -27, 17, 105, 127, -1, 138, 173, 80, 176, 139, -41, 10, 199, -19, -20, 72, 20, 62, -46, 48, 44, -19, 10, 0, 71, 168, -27, -32, 144, 131, 151, 18, 91, -17, 47, 46, 132, 4, 156, 186, 148, 14, 34, 98, 141, 197, -8, 86, -49, 107, 174, 101, 57, 185, 84, 92, -17, 80, 134, 192, 51, 122, 113, 199, 71, 128, -41, 190, -30, 61, 136, 135, 60, 16, 131, 62, 190, 109, 68, 58, -31, -17, 44, -39, 70, 199, 73, 12, 6, 58, 51, 80, 46, 26, 64, 196, 66, 161, 157, -25, 31, 96, 9, 147, -4, 66, 152, 157, 45, 199, 36, 125, 25, 50, 34, -37, 33, 179, 40, -24, 174, 180, 63, -36, 178, -19, 24, 24, 9, 7, -41, 44, -1, 53, 87, -20, 130, 58, -23, -6, 75, 112, 129, -16, 194, 114, 87, 10, 65, 70, 104, 78, -41, 180, 108, 119, 52, 113, 91, 41, 41, 188, 77, -46, 112, -36, 10, 172, 92, 87, 65, 123, 152, 107, -47, 25, 65, 128, 145, -3, 108, 153, 50, 90, 34, 91, 197, 54, 59, 161, 15, 25, 191, 95, -39, 11, 39, -45, 77, -2, 149, 37, 114, 53, 86, 2, 135, -36, 193, 177, 33, 23, -49, 79, 2, -11, 35, 71, 100, -32, 106, -37, 145, 22, -45, 85, -25, 141, 150, -4, 197, 26, 52, 13, 195, 165, 79, -2, 174, 182, 4, 111, 25, 107, 124, 114, 57, -26, 131, 25, 47, -9, 91, -29, 49, -24, 56, 99, 127, 26, 30, 10, 192, 86, 111, 198, -42, -9, 29, 49, 109, 99, -9, 120, -7, 129, -7, 130, 126, 158, 132, 191, 183, -7, 139, 33, -20, 3, 151, 136, 160, 128, 185, 57, 82, 5, 16, 11, -27, 38, 177, -41, 41, 67, 106, -13, 6, 116, 100, 36, 135, 194, -27, 186, 197, 32, 101, -47, 30, 11, -11, -32, -21, 133, 32, -49, 102, 136, 125, -1, 13, 67, 103, 176, 7, 5, 176, -12, 165, 152, 38, 157, 153, 11, 16, 89, 180, 120, -21, 166, 156, 38, 109, 93, -19, -4, 88, 81, 50, 184, 31, 37, -5, 16, -43, 32, -10, 72, 16, 138, 49, -25, 42, -5, 65, -47, 146, 167, 113, 169, -19, 89, -42, -27, -8, 112, -45, -27, 13, 21, 113, 152, 115, 112, -11, -5, 158, 57, 42, 18, -37, -7, 114, 45, 26, -4, 111, 196, -39, -13, 144, 18, 22, 20, 120, 98, 107, 181, 69, -30, 42, 136, 24, 35, 77, 152, 185, 87, 59, 178, 172, 161, 52, 33, 169, 122, -12, 43, -30, 94, 0, 37, -30, 101, 111, 195, 138, 160, -30, 127, 123, 163, 62, 101, 103, 172, 23, 43, -31, 159, 37, 143, 136, 74, 49, 176, 147, 50, 158, 55, 99, -14, 89, 79, 185, 138, -1, 66, -9, -19, -5, 99, 11, 90, 177, 146, 190, 135, -49, 114, 88, 36, 118, -4, 81, 115, 195, 19, 39, 39, 31, 41, -1, 42, 149, 79, 129, 173, 48, 81, 102, 76, 182, 43, -27, 166, 36, 86, 2, -36, 83, 89, 133, 161, 196, -14, 152, 129, 181, 40, 91, 108, -28, 7, 183, -12, 115, -32, 193, 147, 11, 127, 79, -5, 1, 101, 126, -24, 149, 5, -49, -22, 155, -2, 151, 55, 68, 27, 144, 111, -24, 155, 38, 1, 78, 40, 122, 70, 79, 65, 77, 133, 115, 42, -24, 11, 122, 197, 62, -32, 127, 119, 121, 198, -5, 14, -41, 75, 138, 42, 188, 21, 98, 109, 149, -36, -34, 98, -45, 33, 89, 184, 111, 189, 98, -32, -13, 108, 106, 153, -45, 3, 109, 172, 71, 61, 133, 155, 153, 169, -6, 155, 60, 130, 80, 63, 127, 185, 27, 32, 6, -37, -18, 138, 94, 156, -15, 52, 101, 61, 62, 138, -42, 3, -36, 77, 193, 74, -24, 96, 7, -9, 138, 100, 62, -30, 19, 109, 90, -39, 153, 91, 189, 34, 181, -2, 126, 133, 192, 176, 16, 3, 96, -16, 119, 149, -17, 170, 139, -15, 78, -1, 7, 71, 116, -1, -25, -20, 68, -25, 125, 134, 35, 50, 126, -3, 166, 33, 85, -33, 198, 106, 141, -45, -47, 77, 74, 130, 9, 9, 140, 111, 167, 16, -5, -27, 66, -32, 95, 31, 75, -21, 171, 131, 0, -33, 164, 118, 161, 123, 46, -29, 43, -44, 81, 31, 3, 168, 69, -44, 65, 48, -39, 127, 92, -41, 134, -48, 13, 131, 161, 197, -17, -48, 177, 123, -12, 52, 148, 128, 17, -28, -20, 11, 39, 132, 137, 187, 149, 72, -5, 11, -2, -6, 185, 4, 119, -26, -38, 17, -31, -13, -41, 197, 150, 156, 161, 179, 70, 143, 110, -2, 26, -21, -23, 179, 169, 175, 60, -44, -41, 0, 26, -9, 101, 6, 161, 81, 104, 180, 60, 114, 15, 22, 53, 99, 51, 114, 67, 109, -4, -27, 93, 37, 32, 34, 81, -3, 133, -47, 112, 45, -16, 78, -28, 130, 0, 116, -5, 152, 116, 128, 2, 101, -48, 106, 179, 97, 104, 183, -8, 26, 4, 10, 195, 89, 158, -41, 174, 135, -21, 182, 159, -6, -23, 108, 53, 3, 85, 92, 188, 197, -46, 54, 168, 197, 125, -24, 164, 148, 48, 61, -46, 56, -4, 131, 6, 179, -13, -34, -22, 187, 34, 197, 52, 96, 59, 73, -22, 152, 123, 28, -33, -8, 167, -29, -21, 52, -21, 176, 193, 53, 175, 132, 113, 185, 129, 57, 135, -20, 11, 141, 28, -4, 51, 171, 103, -9, 144, 126, 60, -40, 99, 128, 82, -23, -16, 108, 140, 84, -31, -23, -11, 25, 180, 58, -27, 60, 79, 172, 64, 109, -14, 70, 17, 141, 142, -45, 58, 78, 86, -44, 33, 188, -36, 186, 166, 20, 187, 115, 193, 119, 74, 25, 0, -17, -23, 199, 76);

print sum(@array);