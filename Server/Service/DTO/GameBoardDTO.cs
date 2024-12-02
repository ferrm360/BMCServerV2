using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class GameBoardDTO
    {
        [DataMember]
        public int Rows { get; private set; }

        [DataMember]
        public int Columns { get; private set; }

        [DataMember]
        public List<int> Data { get; private set; }

        public GameBoardDTO(int[,] matrix)
        {
            if (matrix == null)
            {
                throw new ArgumentNullException(nameof(matrix));
            }

            Rows = matrix.GetLength(0);
            Columns = matrix.GetLength(1);
            Data = new List<int>();

            for (int i = 0; i < Rows; i++)
            {
                for (int j = 0; j < Columns; j++)
                {
                    Data.Add(matrix[i, j]);
                }
            }
        }

        public int[,] ToMatrix()
        {
            int[,] matrix = new int[Rows, Columns];
            for (int i = 0; i < Rows; i++)
            {
                for (int j = 0; j < Columns; j++)
                {
                    matrix[i, j] = Data[i * Columns + j];
                }
            }
            return matrix;
        }
    }
}
