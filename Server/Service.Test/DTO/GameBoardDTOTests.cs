using Microsoft.VisualStudio.TestTools.UnitTesting;
using Service.DTO;
using System;
using System.Collections.Generic;

namespace Service.Test.DTO
{
    [TestClass]
    public class GameBoardDTOTests
    {
        [TestMethod]
        public void Constructor_ShouldInitializeCorrectly_FromMatrix_CorrectFlow()
        {
            int[,] matrix = new int[,]
            {
                { 1, 2, 3 },
                { 4, 5, 6 }
            };

            var gameBoard = new GameBoardDTO(matrix);

            CollectionAssert.AreEqual(new List<int> { 1, 2, 3, 4, 5, 6 }, gameBoard.Data);
        }

        [TestMethod]
        public void Constructor_ShouldThrowException_WhenMatrixIsNull_FailureFlow()
        {
            Assert.ThrowsException<ArgumentNullException>(() => new GameBoardDTO(null));
        }

        [TestMethod]
        public void Constructor_ShouldHandleEmptyMatrix()
        {
            int[,] matrix = new int[0, 0];

            var gameBoard = new GameBoardDTO(matrix);

            Assert.AreEqual(0, gameBoard.Data.Count);
        }

        [TestMethod]
        public void ToMatrix_ShouldConvertDataBackToMatrixCorrectly()
        {
            int[,] expectedMatrix = new int[,]
            {
                { 1, 2, 3 },
                { 4, 5, 6 }
            };
            var gameBoard = new GameBoardDTO(expectedMatrix);

            var resultMatrix = gameBoard.ToMatrix();

            for (int i = 0; i < resultMatrix.GetLength(0); i++)
            {
                for (int j = 0; j < resultMatrix.GetLength(1); j++)
                {
                    Assert.AreEqual(expectedMatrix[i, j], resultMatrix[i, j], $"Mismatch at position [{i},{j}]");
                }
            }
        }

        [TestMethod]
        public void ToMatrix_ShouldReturnEmptyMatrix_WhenGameBoardIsEmpty()
        {
            var gameBoard = new GameBoardDTO(new int[0, 0]);

            var result = gameBoard.ToMatrix();

            Assert.AreEqual(0, result.Length);
        }

        [TestMethod]
        public void ToMatrix_ShouldReturnConsistentData()
        {
            int[,] originalMatrix = new int[,]
            {
                { 10, 20 },
                { 30, 40 }
            };
            var gameBoard = new GameBoardDTO(originalMatrix);

            // Act
            var resultMatrix = gameBoard.ToMatrix();

            // Assert
            for (int i = 0; i < resultMatrix.GetLength(0); i++)
            {
                for (int j = 0; j < resultMatrix.GetLength(1); j++)
                {
                    Assert.AreEqual(originalMatrix[i, j], resultMatrix[i, j]);
                }
            }
        }

        [TestMethod]
        public void Constructor_ShouldInitializeWithCorrectDimensions()
        {
            // Arrange
            int[,] matrix = new int[,]
            {
                { 1, 2 },
                { 3, 4 }
            };

            // Act
            var gameBoard = new GameBoardDTO(matrix);

            // Assert
            Assert.AreEqual(2, gameBoard.Rows);
            Assert.AreEqual(2, gameBoard.Columns);
        }

        [TestMethod]
        public void Constructor_ShouldFailForInvalidMatrix()
        {
            int[,] matrix = new int[0, 0];

            var gameBoard = new GameBoardDTO(matrix);

            Assert.IsTrue(gameBoard.Rows == 0 && gameBoard.Columns == 0, "Rows or Columns is not zero when expected.");
        }
    }
}
