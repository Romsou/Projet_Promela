#!/usr/bin/python

import sys, math
from termcolor import colored


class Coord:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y

######################### Board #########################


def generate_board(size: int) -> list:
    return [ [2] * size for i in range(size) ]


def generate_european_board(size: int):
    check_board_size_is_odd(size)

    board = generate_english_board(size)
    middle = math.floor(size / 2)
    board[middle][middle] = 1
    board[middle - 1][middle] = 0
    square_size = math.floor(size / 3)

    start = square_size
    end = 2 * square_size

    for y in range(1, middle - math.floor(square_size / 2)):
        for x in range(start, end):
            board[y][x] = 1
        start -= 1
        end += 1

    for y in range(middle + math.floor(square_size / 2), size - 1):
        for x in range(start, end):
            board[y][x] = 1
        start += 1
        end -= 1

    return board


def generate_english_board(size: int):
    check_board_size_is_odd(size)

    board = generate_board(size)
    square_size = int(size / 3)
    middle = math.floor(size / 2)
    branch_width, branch_height = square_size - 1, square_size

    # Central square
    generate_rectangle(board, square_size, square_size, Coord(square_size, square_size))
    board[middle][middle] = 0

    # Vertical line
    generate_rectangle(board, branch_width, branch_height, Coord(square_size, square_size - branch_width))
    generate_rectangle(board, branch_width, branch_height, Coord(square_size, 2 * square_size))

    branch_width, branch_height = branch_height, branch_width

    # Horizontal line
    generate_rectangle(board, branch_width, branch_height, Coord(square_size - branch_height, square_size))
    generate_rectangle(board, branch_width, branch_height, Coord(2 * square_size, square_size))

    return board


def generate_german_board(size: int):
    check_board_size_is_odd(size)

    board = generate_board(size)
    square_size = int(size / 3)
    middle = math.floor(size / 2)

    # Vertical line
    generate_rectangle(board, square_size, square_size, Coord(square_size, 0))
    generate_rectangle(board, square_size, square_size, Coord(square_size, square_size))
    generate_rectangle(board, square_size, square_size, Coord(square_size, 2 * square_size))

    # Horizontal line
    generate_rectangle(board, square_size, square_size, Coord(0, square_size))
    generate_rectangle(board, square_size, square_size, Coord(2 * square_size, square_size))

    # Empty slot in the middle
    board[middle][middle] = 0

    return board


######################## Shapes ########################


def generate_rectangle(board: list, width: int, height: int, coord: Coord) -> list:
    for i in range(width):
        for j in range(height):
            board[coord.y + i][coord.x + j] = 1


######################## File write ########################


def write_board(filename, board):
    header_file = open("templates/header.txt", "r")
    footer_file = open("templates/footer.txt", "r")

    with open(filename, "w") as program:
        program.write(header_file.read() + "\n\n")
        program.write("typedef Matrix {{\n byte column[{}] = 1 \n}}; \n\n".format(len(board)))
        program.write("Matrix matrix[{}];\n".format(len(board)))

        program.write("proctype board() {\n atomic {\n")
        program.write("to_send_move.line_number = 2;\n")
        program.write("to_send_move.column_number = 2;\n")

        for row in range(len(board)):
            for col in range(len(board[row])):
                program.write("matrix[{}].column[{}] = {}\n".format(row, col, board[row][col]))
            program.write("\n")

        program.write(footer_file.read() + "\n\n")

    header_file.close()
    footer_file.close()


######################## Misc ########################


def print_board(board: list):
    for line in board:
        for x in line:
            if x == 1:
                print(colored(1, "red"), end =" ")
            else:
                print(x, end = " ")
        print()


def check_board_size_is_odd(size: int):
    if not (size & 1):
        raise ValueError
        sys.exit(1)


def main():
    print("Quel type de plateau voulez-vous générer ?: ")
    print("1.Européen \t\t 2.Anglais")
    print("3.Allemand ")
    board_type = int(input())

    size = int(input("Quelle taille de plateau voulez-vous ?: "))

    if board_type == 1:
        board = generate_european_board(size)
    elif board_type == 2:
        board = generate_english_board(size)
    elif board_type == 3:
        board = generate_german_board(size)
    else:
        print("Type de plateau inexistant")
        sys.exit(1)

    print_board(board)
    write_board("../solitairePrototype.pml", board)
    print("Programme généré")

if __name__ == '__main__':
    main()
