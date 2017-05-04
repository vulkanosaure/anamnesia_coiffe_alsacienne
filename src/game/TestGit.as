package game 
{
	/**
	 * ...
	 * @author Vincent Huss
	 */
	public class TestGit 
	{
		
		public function TestGit() 
		{
			trace("hello git");
			trace("user 2 added this line");
			
			trace("user 1 add a line in parallele of user 2");
			
		}
		
		
		private function user2Conflict()
		{
			//this function was added by user 2 as a conflict attempt (the 2 push will be done in parallel)
		}
		
	}

}