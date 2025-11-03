package features;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class MasterFlowRunnerTest {

    @Test
    void test() {
        Results results = Runner.path("classpath:features")
                .tags("@e2e-flow")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}