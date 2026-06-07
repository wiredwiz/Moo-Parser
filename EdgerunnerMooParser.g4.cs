namespace Org.Edgerunner.MooSharp.Language.Grammar
{
   partial class EdgerunnerMooParser
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
