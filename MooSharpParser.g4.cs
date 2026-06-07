#region MIT License

// <copyright company="Edgerunner.org" file="MooSharpParser.g4.cs">
// Copyright (c) Thaddeus Ryker 2015
// </copyright>
// The MIT License (MIT)
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#endregion

namespace Org.Edgerunner.MooSharp.Language.Grammar
{
   /// <summary>
   /// Class that represents a parser for the Moo# programming language.
   /// </summary>
   partial class MooSharpParser
   {
      /// <summary>
      /// Tracks how deeply the parser is currently nested inside index/range
      /// brackets ('[' ... ']'). The '$' (last index) and '^' (first index)
      /// literals are only valid while this depth is greater than zero.
      /// </summary>
      private int _indexDepth;

      /// <summary>
      /// Gets a value indicating whether bare '$' / '^' index literals are
      /// currently valid (i.e. the parser is inside an index/range expression).
      /// </summary>
      /// <returns><see langword="true"/> if inside an index/range; otherwise <see langword="false"/>.</returns>
      public bool IndexOk()
      {
         return _indexDepth > 0;
      }

      /// <summary>
      /// Enters an index/range bracket context, enabling bare '$' / '^' literals.
      /// </summary>
      public void EnterIndex()
      {
         _indexDepth++;
      }

      /// <summary>
      /// Exits an index/range bracket context.
      /// </summary>
      public void ExitIndex()
      {
         if (_indexDepth > 0)
            _indexDepth--;
      }
   }
}
