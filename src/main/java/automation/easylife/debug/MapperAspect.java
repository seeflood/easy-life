package automation.easylife.debug;

import java.util.logging.Logger;

@Component
@Aspect
public class MapperAspect {
	 private static final Logger logger = LoggerFactory.getLogger(MapperAspect.class);
	
	 @Before("getMapperPointcut()")
	public void logBefore(JoinPoint jp){
		logger.info("Log Before:"+jp.toString());
	}
	 
	 @After("getMapperPointcut()")
	 public void logAfter(JoinPoint jp){
//		 logger.info("Log After:"+jp.toString());
	 }
	 
	 @Pointcut("execution(* ..*Mapper.*(..))")
	 public void getMapperPointcut(){
	 }
	
}
