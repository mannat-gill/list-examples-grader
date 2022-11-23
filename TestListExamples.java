import static org.junit.Assert.*;
import org.junit.*;
import java.util.*;



class containsA implements StringChecker {
  public boolean checkString(String s) { 
    return true; 
  }
}

public class TestListExamples {


 
  //passed test !
  @Test
  public void passTest(){
    assertEquals(true, true);
  }

  @Test 
  public void test_merge(){
    List<String> expected = new ArrayList<>(Arrays.asList("apple", "grapes", "kiwi", "melon", "orange"));
    
    List<String> list_1 = new ArrayList<>(Arrays.asList( "apple", "melon"));
    List<String> list_2 = new ArrayList<>(Arrays.asList("grapes", "kiwi", "orange"));
    List<String> result =  ListExamples.merge(list_1, list_2); 
    assertEquals(expected, result);
  }

  @Test
  public void test_filter(){
    List<String> input = new ArrayList<>(Arrays.asList("apple", "grapes", "kiwi", "melon", "orange"));
    List<String> result =  ListExamples.filter(input, new containsA()); 
    assertEquals(input, result);
  }
 
  // Write your grading tests here!
}
