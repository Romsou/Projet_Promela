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
            print(x, y)
            board[y][x] = 1
        start -= 1
        end += 1

    for y in range(middle + math.floor(square_size / 2), size - 1):
        for x in range(start, end):
            print(x, y)
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


######################## Misc ########################

def rotate(board, size, matrix):
        middle = math.floor(size / 2)
        half_square_size = int(size / 6)

        for y in range(middle - half_square_size, middle + half_square_size + 1):
            for x in range(1, size - 1):
                if board[y][x] == 1:
                    old_x = x
                    old_y = y

                    x -= middle
                    y -= middle

                    x = math.ceil(x * matrix[0][0] + y * matrix[1][0]) + middle
                    y = math.ceil((old_x - middle) * matrix[0][1] + y * matrix[1][1]) + middle

                    print(x, y)
                    board[y][x] = 1
                    print(board[y][x])

                    x = old_x
                    y = old_y

        return board


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
    board = generate_european_board(9)
    print_board(board)




if __name__ == '__main__':
    main()